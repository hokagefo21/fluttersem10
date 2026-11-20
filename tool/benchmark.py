"""Build a reproducible SQLite fixture and compare identical paged queries."""
import argparse
import datetime as dt
from pathlib import Path
import sqlite3
import statistics
import time
import zipfile

ROOT = Path(__file__).resolve().parents[1]
QUERIES = {
    "Задачи проекта, страница 2": (
        "SELECT id,title FROM tasks WHERE deleted_at IS NULL AND project_id=? "
        "ORDER BY deadline,id LIMIT 25 OFFSET 25", (42,)),
    "Приоритет и поиск по описанию": (
        "SELECT id,title FROM tasks WHERE deleted_at IS NULL AND priority=? "
        "AND instr(fold_text(description),?)>0 ORDER BY deadline,id LIMIT 25", ("high", "отчёт")),
    "Загрузка исполнителя на день": (
        "SELECT count(*) FROM tasks WHERE deleted_at IS NULL AND assignee=? "
        "AND deadline=? AND status IN ('todo','inProgress')", (42, "2026-04-02")),
}

def seed(db):
    db.executescript((ROOT / "lib/database/schema.drift").read_text(encoding="utf-8"))
    db.execute("PRAGMA user_version = 2")
    db.executemany("INSERT INTO users VALUES(?,?,?,'2026-01-01')",
                   ((i, f"Участник {i}", f"person{i}@example.org") for i in range(1, 1001)))
    db.executemany("INSERT INTO projects VALUES(?,?,'','2026-01-01',NULL,'active')",
                   ((i, f"Проект {i}") for i in range(1, 101)))
    db.executemany("INSERT INTO project_members VALUES(?,?,?)",
                   ((1 + (i-1)//10, i, "Owner" if i % 10 == 1 else "Member") for i in range(1, 1001)))
    states = ("todo", "inProgress", "done", "cancelled")
    priorities = ("low", "medium", "high", "critical")
    rows = []
    for i in range(10000):
        user = i % 1000 + 1
        due = dt.date(2026, 4, 1) + dt.timedelta(days=i//1000 + user % 10)
        rows.append((i + 1, f"Задача {i+1}", "Проверить отчёт" if i % 7 == 0 else "Проверить форму",
                     (user-1)//10 + 1, user, states[(i+i//1000) % 4], due.isoformat(),
                     1767225600000 + i, 1767225600000 + i, None, priorities[(i//7) % 4]))
    db.executemany("INSERT INTO tasks VALUES(?,?,?,?,?,?,?,?,?,?,?)", rows)
    db.execute("""INSERT INTO task_history(task_id,kind,new_status,actor,actor_name,created)
                  SELECT t.id,'created',t.status,u.id,u.name,t.created FROM tasks t JOIN users u ON u.id=t.assignee""")
    assert not db.execute("PRAGMA foreign_key_check").fetchall()
    db.commit()

def measure(db):
    data = {}
    for label, (sql, args) in QUERIES.items():
        result = db.execute(sql, args).fetchall()
        plan = "; ".join(r[3] for r in db.execute("EXPLAIN QUERY PLAN " + sql, args))
        for _ in range(10):
            db.execute(sql, args).fetchall()
        samples = []
        for _ in range(100):
            start = time.perf_counter_ns()
            db.execute(sql, args).fetchall()
            samples.append((time.perf_counter_ns() - start)/1000)
        data[label] = (statistics.median(samples), plan, result)
    return data

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("output", type=Path, help="New or empty output directory")
    out = parser.parse_args().output
    out.mkdir(parents=True, exist_ok=True)
    path = out / "taskflow.sqlite"
    if path.exists():
        raise SystemExit(f"Existing database: {path}. Choose a new directory.")
    with sqlite3.connect(path) as db:
        db.execute("PRAGMA foreign_keys=ON")
        db.create_function("fold_text", 1, str.lower, deterministic=True)
        seed(db)
        db.execute("PRAGMA automatic_index=OFF")
        indexed = measure(db)
        # Run the comparison inside a transaction, then restore all indexes.
        db.execute("BEGIN")
        for (name,) in db.execute("SELECT name FROM sqlite_master WHERE type='index' AND sql IS NOT NULL").fetchall():
            db.execute(f'DROP INDEX "{name}"')
        unindexed = measure(db)
        db.rollback()
        counts = [db.execute(f"SELECT count(*) FROM {t}").fetchone()[0] for t in ("users","projects","tasks")]
        assert counts == [1000,100,10000]
    db.close()
    with zipfile.ZipFile(out / "taskflow-benchmark.zip", "w", zipfile.ZIP_DEFLATED) as archive:
        archive.write(path, path.name)
    lines = ["# Сравнение запросов", "", f"SQLite {sqlite3.sqlite_version}. 1 000 пользователей, 100 проектов, 10 000 задач.",
             "Для каждого запроса выполнены 10 прогревов и 100 замеров на одной файловой базе. В таблице приведены медианы в микросекундах. Автоматические индексы отключены в обоих прогонах. Первичные и уникальные ключи сохранены.", "",
             "| Запрос | Без индексов, мкс | С индексами, мкс |", "|---|---:|---:|"]
    for label in QUERIES:
        assert indexed[label][2] == unindexed[label][2]
        lines.append(f"| {label} | {unindexed[label][0]:.1f} | {indexed[label][0]:.1f} |")
    for label in QUERIES:
        lines += ["", f"## {label}", "", f"С индексами — `{indexed[label][1]}`.", "",
                  f"Без индексов — `{unindexed[label][1]}`."]
    (out / "benchmark.md").write_text("\n".join(lines)+"\n", encoding="utf-8")
    print("Verified 1000 users, 100 projects, 10000 tasks, equal query results.")
if __name__ == "__main__":
    main()
