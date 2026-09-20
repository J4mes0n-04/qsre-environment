# Runbook QSRE review

## Приём от ASE

1. Получить `ase-to-qsre.json`.
2. Проверить Schema v1.0.0.
3. Проверить Pack SHA, implementation SHA, PR URLs и delivery slices.
4. Проверить coverage и обязательные references.
5. Записать ACK или вернуть конкретные gaps.

## Независимая проверка

1. Проверить каждый AC/NFR по исходному Pack и evidence.
2. Проверить environment, execution time, reproducibility и immutable URLs.
3. Проверить security assumptions и threat analysis, если требуется риском.
4. Проверить rollout, stop conditions и исполнимость rollback.
5. Записать ограничения, residual risk и release recommendation.

## Обратная связь

- `clarification` — определение или доказательство непонятно;
- `definition-change` — требуется изменить Pack;
- `defect` — реализация не соответствует действующему Pack;
- `governance-signal` — проблема общей нормы или процесса.

QSRE формирует `qsre-to-pde.json`, указывает evidence и требуемое решение. PDE отвечает через `pde_response`; дефект реализации отдельно направляется ASE.

После ручной проверки feedback можно запустить workflow `notify-pde-feedback`. Он создаёт Issue в PDE и не объединяет Pull Request.

