# Сравнение запросов

SQLite 3.50.4. 1 000 пользователей, 100 проектов, 10 000 задач.
Для каждого запроса выполнены 10 прогревов и 100 замеров на одной файловой базе. В таблице приведены медианы в микросекундах. Автоматические индексы отключены в обоих прогонах. Первичные и уникальные ключи сохранены.

| Запрос | Без индексов, мкс | С индексами, мкс |
|---|---:|---:|
| Задачи проекта, страница 2 | 601.2 | 68.6 |
| Приоритет и поиск по описанию | 2366.0 | 223.1 |
| Загрузка исполнителя на день | 524.3 | 54.6 |

## Задачи проекта, страница 2

С индексами — `SEARCH tasks USING INDEX task_project_due (project_id=?)`.

Без индексов — `SEARCH tasks USING INDEX task_project_due (project_id=?)`.

## Приоритет и поиск по описанию

С индексами — `SEARCH tasks USING INDEX task_priority_due (priority=?)`.

Без индексов — `SEARCH tasks USING INDEX task_priority_due (priority=?)`.

## Загрузка исполнителя на день

С индексами — `SEARCH tasks USING INDEX task_assignee_due (assignee=? AND deadline=? AND status=?)`.

Без индексов — `SEARCH tasks USING INDEX task_assignee_due (assignee=? AND deadline=? AND status=?)`.
