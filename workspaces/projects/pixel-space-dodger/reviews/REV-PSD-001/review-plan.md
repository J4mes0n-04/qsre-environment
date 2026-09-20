# План независимой проверки QSRE

- Review ID: `REV-PSD-001`
- Outcome ID: `OUT-PSD-001`
- ASE handoff ID: отсутствует
- Pack commit SHA: `5fa996cf140a65109af3ccebd3848e1d7566745d`
- Implementation commit SHA: `fbfb06ead2b0cc6456a85356a2f2c12a56f5098e`
- QSRE owner: QSRE Owner

## Проверки требований

Метод: статический разбор `index.html` / `js/game.js` / `js/storage.js` / `start-game.ps1` + runtime в Chromium-based browser (`http://127.0.0.1:8877/index.html`) на машине QSRE.

Ожидаемое доказательство: скриншоты меню / партии / Game Over / Рекордов, localStorage после reload, код launcher.

## Security review

Риск `R1`, автономия `A1`. Угрозы минимальны (локальная HTML/JS игра без сети и без npm). Контроль: отсутствие внешних зависимостей (`package.json` нет). Исключений на Definition Change нет.

## Release review

Rollout по Pack: локальный запуск по README. Stop conditions: окно не открывается / AC не выполняется. Rollback: предыдущий commit продукта. Практически rollback не проверен на опубликованном remote (remote отсутствует).

## Ограничения проверки

- Формальный ASE → QSRE handoff недоступен.
- Runtime QSRE шёл во вкладке браузера, не через `start-game.cmd --app`.
- Бинарные скриншоты не кладутся в QSRE repository (запрет artifacts); наблюдения зафиксированы в `independent-verification.md`.
- Публичные immutable URLs на evidence отсутствуют.
