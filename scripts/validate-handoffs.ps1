[CmdletBinding()]
param(
    [string]$AseHandoffPath,
    [string]$QsreFeedbackPath
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$controlRoot = Join-Path $repoRoot 'vendor/engineering-control'
$failures = [System.Collections.Generic.List[string]]::new()

if (-not $AseHandoffPath -and -not $QsreFeedbackPath) {
    $AseHandoffPath = Join-Path $controlRoot 'contracts/examples/ase-to-qsre.example.json'
    $QsreFeedbackPath = Join-Path $controlRoot 'contracts/examples/qsre-to-pde.example.json'
}

function Test-ContractFile {
    param(
        [string]$Path,
        [string]$SchemaName,
        [string]$ExpectedType,
        [string]$ExpectedVersion
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        $script:failures.Add("Contract file not found: $Path")
        return $null
    }
    $schemaPath = Join-Path $controlRoot "contracts/$SchemaName"
    if (-not (Test-Path -LiteralPath $schemaPath)) {
        $script:failures.Add("Pinned contract schema not found: $schemaPath")
        return $null
    }

    try {
        $text = Get-Content -Raw -LiteralPath $Path
        $data = $text | ConvertFrom-Json -Depth 100
        if (-not ($text | Test-Json -SchemaFile $schemaPath -ErrorAction Stop)) {
            $script:failures.Add("Schema validation failed: $Path")
        }
        if ($data.contract_type -ne $ExpectedType) {
            $script:failures.Add("Unexpected contract_type in ${Path}: $($data.contract_type)")
        }
        if ($data.contract_version -ne $ExpectedVersion) {
            $script:failures.Add("Unsupported contract_version in ${Path}: $($data.contract_version)")
        }
        return $data
    } catch {
        $script:failures.Add("Invalid contract ${Path}: $($_.Exception.Message)")
        return $null
    }
}

$ase = $null
$qsre = $null
if ($AseHandoffPath) {
    $ase = Test-ContractFile -Path $AseHandoffPath -SchemaName 'ase-to-qsre.schema.json' -ExpectedType 'ase-to-qsre' -ExpectedVersion '1.0.0'
    if ($ase) {
        $coverageIds = @($ase.coverage.requirement_id)
        foreach ($duplicate in @($coverageIds | Group-Object | Where-Object Count -gt 1)) {
            $failures.Add("ASE handoff contains duplicate coverage for requirement: $($duplicate.Name)")
        }
    }
}
if ($QsreFeedbackPath) {
    $qsre = Test-ContractFile -Path $QsreFeedbackPath -SchemaName 'qsre-to-pde.schema.json' -ExpectedType 'qsre-to-pde' -ExpectedVersion '1.0.0'
}

if ($ase -and $qsre) {
    if ($qsre.outcome_id -ne $ase.outcome_id) {
        $failures.Add('Input and feedback use different outcome_id values')
    }
    if ($qsre.pack.commit_sha -ne $ase.pack.commit_sha -or $qsre.pack.version -ne $ase.pack.version) {
        $failures.Add('QSRE feedback changed Pack commit SHA or version')
    }
    if ($qsre.implementation.commit_sha -ne $ase.implementation.commit_sha) {
        $failures.Add('QSRE feedback does not reference the reviewed implementation commit SHA')
    }

    $knownIdentifiers = @($ase.coverage.requirement_id) + @($ase.implementation.delivery_slice_ids) + @($ase.residual_risks.id)
    foreach ($identifier in @($qsre.affected_identifiers)) {
        if ($identifier -match '^(AC|NFR|SLICE|RISK)-' -and $identifier -notin $knownIdentifiers) {
            $failures.Add("QSRE feedback references an identifier absent from ASE handoff: $identifier")
        }
    }
}

if ($failures.Count -gt 0) {
    Write-Error ($failures -join [Environment]::NewLine)
    exit 1
}

$validated = @($AseHandoffPath, $QsreFeedbackPath | Where-Object { $_ }).Count
Write-Host "QSRE handoff validation passed. Contract files checked: $validated."
exit 0

