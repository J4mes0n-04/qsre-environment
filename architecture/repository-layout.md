# Структура QSRE-репозитория

- `vendor/engineering-control/` — read-only общая основа;
- `config/` — control pin и feature flags;
- `architecture/` — границы среды;
- `operations/` — инструкции проверки;
- `templates/` — ACK, review plan и release decision;
- `workspaces/projects/` — review records и ссылки;
- `.agents/skills/`, `.cursor/rules/` — QSRE-specific поведение;
- `scripts/`, `.github/` — автоматические gates.

Код продукта, полный Pack, ASE workspace и бинарные artifacts не копируются.

