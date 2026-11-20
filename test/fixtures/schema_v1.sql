CREATE TABLE users (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 name TEXT NOT NULL CHECK(length(trim(name)) > 0),
 email TEXT NOT NULL COLLATE NOCASE UNIQUE CHECK(length(trim(email)) > 0),
 registered TEXT NOT NULL
);
CREATE TABLE projects (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 name TEXT NOT NULL CHECK(length(trim(name)) > 0),
 description TEXT NOT NULL,
 created TEXT NOT NULL,
 finish TEXT CHECK(finish IS NULL OR finish >= created),
 status TEXT NOT NULL CHECK(status IN ('active','completed','archived'))
);
CREATE TABLE project_members (
 project_id INTEGER NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
 user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 role TEXT NOT NULL CHECK(role IN ('Owner','Admin','Member')),
 PRIMARY KEY(project_id,user_id)
);
CREATE TABLE tasks (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 title TEXT NOT NULL CHECK(length(trim(title)) > 0),
 description TEXT NOT NULL,
 project_id INTEGER NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
 assignee INTEGER REFERENCES users(id) ON DELETE SET NULL,
 status TEXT NOT NULL CHECK(status IN ('todo','inProgress','done','cancelled')),
 deadline TEXT NOT NULL,
 created INTEGER NOT NULL,
 updated INTEGER NOT NULL,
 deleted_at INTEGER
);
CREATE TABLE comments (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 task_id INTEGER NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
 author INTEGER REFERENCES users(id) ON DELETE SET NULL,
 author_name TEXT NOT NULL,
 body TEXT NOT NULL CHECK(length(trim(body)) > 0),
 created INTEGER NOT NULL
);
CREATE TABLE attachments (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 task_id INTEGER NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
 name TEXT NOT NULL,
 path TEXT NOT NULL UNIQUE,
 created INTEGER NOT NULL
);
CREATE TABLE task_history (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 task_id INTEGER NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
 kind TEXT NOT NULL CHECK(kind IN ('created','status','assignee','undo')),
 old_status TEXT,
 new_status TEXT NOT NULL,
 actor INTEGER REFERENCES users(id) ON DELETE SET NULL,
 actor_name TEXT NOT NULL,
 old_assignee TEXT,
 new_assignee TEXT,
 undo_of INTEGER UNIQUE REFERENCES task_history(id) ON DELETE CASCADE,
 created INTEGER NOT NULL
);
CREATE INDEX task_project_due ON tasks(project_id, deadline, id) WHERE deleted_at IS NULL;
CREATE INDEX task_assignee_due ON tasks(assignee, deadline, status) WHERE deleted_at IS NULL;
CREATE INDEX task_status_due ON tasks(status, deadline, id) WHERE deleted_at IS NULL;
CREATE INDEX task_created ON tasks(created, id) WHERE deleted_at IS NULL;
CREATE INDEX task_due ON tasks(deadline, id) WHERE deleted_at IS NULL;
CREATE INDEX comment_task ON comments(task_id, id);
CREATE INDEX attachment_task ON attachments(task_id, id);
CREATE INDEX history_task ON task_history(task_id, id);
PRAGMA user_version=1;
