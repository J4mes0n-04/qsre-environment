# Инструкции репозитория QSRE

## Язык

- Человекочитаемые документы и review records пишите на русском языке.
- Имена файлов, JSON/YAML keys, код, enum values и устойчивые идентификаторы оставляйте на английском.
- Сложный английский термин при первом использовании поясняйте по-русски.

## Независимость проверки

- Проверяйте вход по закреплённым contracts из `vendor/engineering-control`.
- Не принимайте утверждения ASE без immutable evidence.
- Не исправляйте код продукта или Pack в рамках QSRE review.
- Не меняйте scope, AC/NFR, риск или продуктовый смысл.
- Классифицируйте проблему как clarification, definition-change, defect или governance-signal.

## Evidence и выпуск

- Для каждого AC/NFR проверьте результат, test reference, evidence ID, environment и execution time.
- Зеленый CI сам по себе не доказывает готовность Outcome.
- Проверьте rollout, stop conditions и практичность rollback.
- Остаточный риск может принять только уполномоченный владелец.
- При недостаточных доказательствах release recommendation не может быть `approve`.

## Рабочие файлы

- Создавайте review только в `workspaces/projects/<project-id>/reviews/<review-id>/`.
- Не помещайте код продукта, полный Pack, secrets или бинарные artifacts в QSRE repository.
- Не изменяйте `vendor/engineering-control` из review-задачи.
- Не смешивайте платформенное изменение и конкретный review в одном Pull Request.

## Инструменты

- OpenSpace работает только локально и не меняет governance автоматически.
- Внешние интеграции и облачная передача требуют отдельного решения.
- Secrets хранятся вне Git.

## Проверка

```powershell
pwsh ./scripts/doctor.ps1
pwsh ./scripts/validate-repository.ps1
pwsh ./scripts/validate-handoffs.ps1 -AseHandoffPath <input> -QsreFeedbackPath <output>
```

Не обходите contract gate и сообщайте о нерешённых пробелах.

