# Системный контекст QSRE

QSRE получает от ASE ссылки на Pack, реализацию, coverage, Evidence Bundle и release plan. Среда независимо оценивает достаточность доказательств и готовность выпуска. Результат фиксируется как release decision и, при наличии сигнала, как QSRE → PDE feedback.

`engineering-control` определяет contract semantics. Код продукта остаётся в продуктовом репозитории, Pack — в PDE, а исправления реализации выполняет ASE.

