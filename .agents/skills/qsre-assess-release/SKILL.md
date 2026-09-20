---
name: qsre-assess-release
description: Оценивает security, rollout, stop conditions, rollback и формирует release recommendation.
---

# Оценка выпуска

1. Проверьте обязательные evidence и security controls.
2. Проверьте staged rollout и измеримые stop conditions.
3. Убедитесь, что rollback исполним и имеет критерии успеха.
4. Проверьте полномочия лица, принимающего residual risk.
5. Заполните `templates/release-decision.md`.
6. При блокирующем пробеле используйте `hold` или `rollback`.

