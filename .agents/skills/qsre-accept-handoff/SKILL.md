---
name: qsre-accept-handoff
description: Проверяет ASE → QSRE handoff и формирует независимый ACK до review.
---

# Приём ASE handoff

1. Прочитайте control pin и входной JSON.
2. Запустите `scripts/validate-handoffs.ps1` для входа.
3. Проверьте Pack SHA, implementation SHA, coverage, evidence, release и risks.
4. При пробеле верните `needs-clarification` с конкретными gaps.
5. При готовности заполните `templates/qsre-ack.md`.

