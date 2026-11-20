# TaskFlow: Practical Assignment 10

TaskFlow is an offline Flutter app for managing projects and tasks. SQLite stores data on the device. Drift updates the screens when records change. The installed app works without an account or an internet connection.

## Run in Android Studio

Open the project root containing `pubspec.yaml`, select an Android emulator or phone, and run `lib/main.dart`. To launch from a terminal:

```sh
flutter pub get
flutter run
```

The generated Drift code is included. After editing the schema, run `dart run build_runner build`.

## Demo

1. In the people tab, create a user with a name and email address. The app selects the first user automatically. Use the profile icon to choose who performs actions on this device.
2. In the projects tab, create a project and open it. Add a participant and assign the Owner, Admin, or Member role. Tap a participant to edit the role.
3. Open the project's tasks. Create a task, choose an assignee and priority, and set a deadline. Use the pencil icon to change its status. The history records both statuses, the actor, and the time. Undo restores the previous status and adds a history entry.
4. Add a comment or attach a file. TaskFlow copies the file into its own directory and stores its name, path, and timestamp in SQLite. Each local user can delete their own comments.
5. Search, filter, or sort in the tasks tab. Each page contains up to 25 tasks. Tap a person to see their assignments across projects.
6. Move a task to the trash, check the dashboard, and restore it using the trash icon. Close and reopen the app to verify persistence.

## Database rules

The seven tables are defined in `lib/database/schema.drift`. A composite key on `project_members` links users to projects. Each database connection enables foreign keys. Email addresses are unique with case-insensitive comparison.

Creating a task and its initial history entry takes one transaction. Reassignment checks membership and the assignee's workload, updates the task, and records the event atomically. A person may have up to three open tasks due on the same calendar day across all projects. The same rule applies on restore and when reopening a task.

Open statuses are `todo` and `inProgress`. Users with open tasks, including tasks in the trash, cannot be deleted. Comments and history retain a deleted user's name. Deleting a project removes its tasks and dependent records. Individual tasks can be permanently deleted from the trash.

The dashboard uses SQL aggregation. An open task is overdue when its deadline falls before today. Project completion is the percentage of tasks outside the trash with status `done`. An empty project shows 0%. Cancelled tasks count toward the total and are excluded from open and overdue counts.

## Source layout

| Directory | Contents |
| --- | --- |
| `lib/database` | Schema, SQLite connection, and migration from v1 to v2 |
| `lib/model` | Task input, filters, and dashboard metrics |
| `lib/repository` | Queries, business rules, transactions, and attachments |
| `lib/state` | Reactive project and user state and current actor |
| `lib/presentation` | Forms, lists, details, trash, and dashboard |

## Tests and benchmark

```sh
flutter analyze
flutter test
flutter build apk --debug
```

Tests cover CRUD, relationships, daily limits, transaction rollback after a history failure, undo, comment ownership, files, cascades, trash, dashboard metrics, search, pagination, and reactive updates. The migration test creates a v1 SQLite file with a task and history, opens it with Drift v2, and reopens it. The original task receives medium priority and retains its contents and relationships.

The archived database contains 1,000 test users, 100 projects, and 10,000 tasks with initial history entries. Extract the archive and open `taskflow.sqlite` in a SQLite viewer. The app creates its working database separately. [Sample database](docs/taskflow-benchmark.zip) | [Timings and query plans](docs/benchmark.md)

To reproduce the comparison, run `python tool/benchmark.py benchmark-output` from the project root. The script creates a database in a new directory, checks that both query runs return identical results, records median times with and without indexes, and archives the indexed database.

## Android verification

On an Android API 36 emulator in airplane mode, a task was created, its status changed, and a comment added. After a full process stop and restart, the task details still showed the assignee, comment, and history. Static analysis, 23 automated tests, and an Android emulator debug build passed on Windows. [Task details after restart](docs/evidence/offline-task.png)
