# QSRE operating environment

Этот репозиторий — рабочая среда **QSRE (Quality, Security and Release Engineering)**. QSRE независимо проверяет реализацию и доказательства, оценивает безопасность и готовность выпуска, а затем возвращает PDE структурированную обратную связь.

> **Статус:** `0.1.0-shadow`. Среда предназначена для shadow pilot, а не для production. Общая основа закреплена на `engineering-control v1.0.0-rc.1`; она остаётся `staging`, `authoritative: false`, а контракты — `draft`.

## Граница ответственности

QSRE отвечает за:

- приём и проверку ASE → QSRE handoff;
- явный ACK входной передачи;
- независимую проверку покрытия AC/NFR;
- проверку качества evidence, среды и времени выполнения;
- оценку security, release, stop conditions и rollback;
- фиксацию остаточного риска и release recommendation;
- QSRE → PDE feedback: `clarification`, `definition-change`, `defect` или `governance-signal`.

QSRE не переписывает Pack, не исправляет реализацию вместо ASE и не принимает продуктовые решения вместо PDE. Обнаруженный пробел классифицируется и возвращается владельцу соответствующего источника истины.

## Архитектура

```text
engineering-control v1.0.0-rc.1 (read-only submodule)
                         |
ASE handoff -------------v
                   QSRE intake + ACK
                         |
              evidence/security/release review
                         |
                release recommendation
                         |
                QSRE -> PDE feedback
                  |               |
             defect -> ASE   definition -> PDE
```

Код продукта, Pack и CI artifacts не копируются в этот репозиторий. В `workspaces/projects/` хранятся review records и неизменяемые ссылки.

## Быстрый старт

```powershell
git clone --recurse-submodules https://github.com/J4mes0n-04/qsre-environment.git
Set-Location qsre-environment
pwsh ./scripts/doctor.ps1
pwsh ./scripts/validate-repository.ps1
pwsh ./scripts/validate-handoffs.ps1
```

Если submodule не был загружен:

```powershell
git submodule update --init --recursive
```

## Рабочий поток

1. Создайте `workspaces/projects/<project-id>/reviews/<review-id>/`.
2. Сохраните входной `ase-to-qsre.json` без смысловых изменений.
3. Проверьте contract и неизменяемые ссылки.
4. Заполните ACK. При неполном входе верните конкретные gaps.
5. Составьте независимый review plan.
6. Проверьте каждый AC/NFR, evidence, security, rollout и rollback.
7. Зафиксируйте release decision record.
8. При обнаружении сигнала сформируйте `qsre-to-pde.json` и проверьте цепочку SHA.
9. Не закрывайте сигнал без ответа PDE и closure evidence, если он обязателен.

Подробности: [operations/review-runbook.md](operations/review-runbook.md).

## Общая основа

[config/control-plane.yaml](config/control-plane.yaml) фиксирует:

- tag `v1.0.0-rc.1`;
- commit `abd0982171341438cab80267099b951a2027be0b`;
- contracts `1.0.0`;
- mode `shadow`.

`vendor/engineering-control` является read-only dependency. Обновление допускается только через отдельный Pull Request и compatibility checks.

## Дополнительные инструменты

OpenSpace, Unleash, OpenTelemetry и Grafana первоначально выключены. Они включаются только после настройки подключения, владельцев, хранения данных и security review.

## Основные каталоги

- `architecture/` — границы QSRE;
- `config/` — control pin и feature flags;
- `templates/` — ACK, review plan и release decision;
- `scripts/` — doctor и validators;
- `operations/` — onboarding и runbook;
- `workspaces/projects/` — review records;
- `.agents/skills/` — QSRE-specific skills;
- `vendor/engineering-control/` — закреплённая общая основа.

