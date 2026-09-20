---
name: qsre-verify-evidence
description: Независимо проверяет покрытие AC/NFR и качество неизменяемых доказательств.
---

# Проверка evidence

1. Возьмите AC/NFR из Pack по закреплённому SHA.
2. Для каждого требования проверьте test reference, evidence ID, result, environment и время.
3. Проверьте воспроизводимость и неизменяемость references.
4. Не принимайте `partial` или `not-run` как pass.
5. Зафиксируйте gaps, ограничения и остаточный риск.

