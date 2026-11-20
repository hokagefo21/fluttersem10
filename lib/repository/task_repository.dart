import 'dart:io';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import '../database/database.dart';
import '../model/task_model.dart';

class TaskRepository {
  final TaskDatabase db;
  final Directory files;
  TaskRepository(this.db, this.files);
  int get now => DateTime.now().millisecondsSinceEpoch;
  Stream<List<User>> users() =>
      (db.select(db.users)..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();
  Stream<List<Project>> projects() => (db.select(
    db.projects,
  )..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();
  Stream<List<Task>> task(int id) =>
      (db.select(db.tasks)..where((t) => t.id.equals(id))).watch();
  Stream<List<Comment>> comments(int id) =>
      (db.select(db.comments)
            ..where((c) => c.taskId.equals(id))
            ..orderBy([(c) => OrderingTerm.asc(c.id)]))
          .watch();
  Stream<List<TaskHistoryData>> history(int id) =>
      (db.select(db.taskHistory)
            ..where((c) => c.taskId.equals(id))
            ..orderBy([(c) => OrderingTerm.desc(c.id)]))
          .watch();
  Stream<List<Attachment>> attachments(int id) =>
      (db.select(db.attachments)..where((c) => c.taskId.equals(id))).watch();
  Stream<List<ProjectMember>> members(int id) => (db.select(
    db.projectMembers,
  )..where((m) => m.projectId.equals(id))).watch();

  Future<int> saveUser(
    String name,
    String email,
    String date, {
    int? id,
  }) async {
    final address = email.trim().toLowerCase();
    if (name.trim().isEmpty ||
        !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(address)) {
      throw const RuleError('Введите имя и корректный email');
    }
    return db.transaction(() async {
      final same = await (db.select(
        db.users,
      )..where((u) => u.email.equals(address))).getSingleOrNull();
      if (same != null && same.id != id) {
        throw const RuleError('Этот email уже зарегистрирован');
      }
      final data = UsersCompanion(
        name: Value(name.trim()),
        email: Value(address),
        registered: Value(checkedDay(date)),
      );
      if (id == null) return db.into(db.users).insert(data);
      await (db.update(db.users)..where((u) => u.id.equals(id))).write(data);
      return id;
    });
  }

  Future<void> deleteUser(int id) => db.transaction(() async {
    final pending = await db
        .customSelect(
          "SELECT 1 FROM tasks WHERE assignee=? AND status IN ('todo','inProgress') LIMIT 1",
          variables: [Variable(id)],
        )
        .get();
    if (pending.isNotEmpty) {
      throw const RuleError(
        'Сначала завершите или переназначьте задачи пользователя (включая корзину)',
      );
    }
    await (db.delete(db.users)..where((u) => u.id.equals(id))).go();
    _cascade();
  });
  Future<int> saveProject(
    String name,
    String description,
    String created,
    String? finish,
    String status, {
    int? id,
  }) async {
    if (name.trim().isEmpty || !projectStates.containsKey(status)) {
      throw const RuleError('Проверьте название и статус проекта');
    }
    checkedDay(created);
    if (finish != null && checkedDay(finish).compareTo(created) < 0) {
      throw const RuleError('Завершение раньше создания');
    }
    final data = ProjectsCompanion(
      name: Value(name.trim()),
      description: Value(description.trim()),
      created: Value(created),
      finish: Value(finish),
      status: Value(status),
    );
    if (id == null) return db.into(db.projects).insert(data);
    await (db.update(db.projects)..where((t) => t.id.equals(id))).write(data);
    return id;
  }

  Future<void> member(
    int project,
    int user,
    String role, {
    bool edit = false,
  }) async {
    if (!roles.contains(role)) throw const RuleError('Неизвестная роль');
    final match = db.select(db.projectMembers)
      ..where((m) => m.projectId.equals(project) & m.userId.equals(user));
    await db.transaction(() async {
      if (edit) {
        await (db.update(db.projectMembers)..where(
              (m) => m.projectId.equals(project) & m.userId.equals(user),
            ))
            .write(ProjectMembersCompanion(role: Value(role)));
      } else {
        if (await match.getSingleOrNull() != null) {
          throw const RuleError('Участник уже добавлен');
        }
        await db
            .into(db.projectMembers)
            .insert(
              ProjectMembersCompanion.insert(
                projectId: project,
                userId: user,
                role: role,
              ),
            );
      }
    });
  }

  Future<void> removeMember(int project, int user) => db.transaction(() async {
    final assigned =
        await (db.select(db.tasks)
              ..where(
                (t) => t.projectId.equals(project) & t.assignee.equals(user),
              )
              ..limit(1))
            .get();
    if (assigned.isNotEmpty) {
      throw const RuleError('Сначала переназначьте задачи этого участника');
    }
    await (db.delete(
      db.projectMembers,
    )..where((m) => m.projectId.equals(project) & m.userId.equals(user))).go();
  });
  void _cascade() =>
      db.notifyUpdates({for (final t in db.allTables) TableUpdate.onTable(t)});
  Future<void> deleteProject(int id) async {
    final paths = await db.transaction(() async {
      final paths = await db
          .customSelect(
            'SELECT path FROM attachments JOIN tasks ON tasks.id=attachments.task_id WHERE tasks.project_id=?',
            variables: [Variable(id)],
          )
          .map((r) => r.read<String>('path'))
          .get();
      await (db.delete(db.projects)..where((t) => t.id.equals(id))).go();
      _cascade();
      return paths;
    });
    await _unlink(paths);
  }

  Future<void> _checkAssignment(
    int project,
    int assignee,
    String due,
    String status,
    int? exclude,
  ) async {
    final member =
        await (db.select(db.projectMembers)..where(
              (m) => m.projectId.equals(project) & m.userId.equals(assignee),
            ))
            .getSingleOrNull();
    if (member == null) {
      throw const RuleError('Исполнитель должен состоять в проекте');
    }
    if (status == 'done' || status == 'cancelled') return;
    final count = await db
        .customSelect(
          "SELECT COUNT(*) AS n FROM tasks WHERE assignee=? AND deadline=? AND id<>? AND deleted_at IS NULL AND status IN ('todo','inProgress')",
          variables: [
            Variable(assignee),
            Variable(due),
            Variable(exclude ?? -1),
          ],
        )
        .getSingle();
    if (count.read<int>('n') >= 3) {
      throw const RuleError(
        'На эту дату уже назначены три незавершённые задачи',
      );
    }
  }

  Future<User> _user(int id) async {
    final u = await (db.select(
      db.users,
    )..where((u) => u.id.equals(id))).getSingleOrNull();
    if (u == null) throw const RuleError('Выберите действующего пользователя');
    return u;
  }

  Future<Task> _task(int id, {bool trash = false}) async {
    final t = await (db.select(
      db.tasks,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (t == null || (t.deletedAt != null) != trash) {
      throw const RuleError('Задача недоступна');
    }
    return t;
  }

  Future<void> _event(
    int task,
    String kind,
    String? old,
    String status,
    int actor, {
    String? from,
    String? to,
    int? undo,
  }) async {
    final u = await _user(actor);
    await db
        .into(db.taskHistory)
        .insert(
          TaskHistoryCompanion.insert(
            taskId: task,
            kind: kind,
            oldStatus: Value(old),
            newStatus: status,
            actor: Value(actor),
            actorName: u.name,
            oldAssignee: Value(from),
            newAssignee: Value(to),
            undoOf: Value(undo),
            created: now,
          ),
        );
  }

  Future<int> saveTask(TaskInput input, int actor, {int? id}) => db.transaction(
    () async {
      if (input.title.trim().isEmpty ||
          !statuses.containsKey(input.status) ||
          !priorities.containsKey(input.priority)) {
        throw const RuleError('Проверьте название, статус и приоритет');
      }
      checkedDay(input.deadline);
      final old = id == null ? null : await _task(id);
      if (old != null && old.projectId != input.project) {
        throw const RuleError('Проект задачи нельзя изменить');
      }
      await _user(actor);
      await _checkAssignment(
        input.project,
        input.assignee,
        input.deadline,
        input.status,
        id,
      );
      final t = TasksCompanion(
        title: Value(input.title.trim()),
        description: Value(input.description.trim()),
        projectId: Value(input.project),
        assignee: Value(input.assignee),
        status: Value(input.status),
        deadline: Value(input.deadline),
        priority: Value(input.priority),
        created: Value(old?.created ?? now),
        updated: Value(now),
      );
      if (old == null) {
        final newId = await db.into(db.tasks).insert(t);
        await _event(
          newId,
          'created',
          null,
          input.status,
          actor,
          to: (await _user(input.assignee)).name,
        );
        return newId;
      }
      await (db.update(db.tasks)..where((t) => t.id.equals(old.id))).write(t);
      if (old.status != input.status) {
        await _event(old.id, 'status', old.status, input.status, actor);
      }
      if (old.assignee != input.assignee) {
        await _event(
          old.id,
          'assignee',
          old.status,
          input.status,
          actor,
          from: old.assignee == null ? null : (await _user(old.assignee!)).name,
          to: (await _user(input.assignee)).name,
        );
      }
      return old.id;
    },
  );
  Future<void> undo(int id, int actor) => db.transaction(() async {
    final t = await _task(id);
    final event = await db
        .customSelect(
          "SELECT id,old_status,new_status FROM task_history h WHERE task_id=? AND kind='status' AND NOT EXISTS(SELECT 1 FROM task_history u WHERE u.undo_of=h.id) ORDER BY id DESC LIMIT 1",
          variables: [Variable(id)],
        )
        .getSingleOrNull();
    if (event == null || event.read<String>('new_status') != t.status) {
      throw const RuleError('Нет изменения статуса для отмены');
    }
    final previous = event.read<String>('old_status');
    if (t.assignee != null) {
      await _checkAssignment(
        t.projectId,
        t.assignee!,
        t.deadline,
        previous,
        id,
      );
    } else if (previous == 'todo' || previous == 'inProgress') {
      throw const RuleError('Сначала назначьте исполнителя');
    }
    await (db.update(db.tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(status: Value(previous), updated: Value(now)),
    );
    await _event(
      id,
      'undo',
      t.status,
      previous,
      actor,
      undo: event.read<int>('id'),
    );
  });
  Future<void> trash(int id) async {
    await (db.update(db.tasks)
          ..where((t) => t.id.equals(id) & t.deletedAt.isNull()))
        .write(TasksCompanion(deletedAt: Value(now), updated: Value(now)));
  }

  Future<void> restore(int id) => db.transaction(() async {
    final t = await _task(id, trash: true);
    if (t.assignee != null) {
      await _checkAssignment(
        t.projectId,
        t.assignee!,
        t.deadline,
        t.status,
        id,
      );
    }
    await (db.update(db.tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(deletedAt: const Value(null), updated: Value(now)),
    );
  });
  Future<void> purge(int id) async {
    final paths = await db.transaction(() async {
      await _task(id, trash: true);
      final files = await (db.select(
        db.attachments,
      )..where((a) => a.taskId.equals(id))).get();
      await (db.delete(db.tasks)..where((t) => t.id.equals(id))).go();
      _cascade();
      return files.map((a) => a.path);
    });
    await _unlink(paths);
  }

  Future<void> _unlink(Iterable<String> paths) async {
    for (final path in paths) {
      final f = File(path);
      if (p.isWithin(files.absolute.path, f.absolute.path) &&
          await f.exists()) {
        await f.delete();
      }
    }
  }

  Future<void> comment(int task, int actor, String body) =>
      db.transaction(() async {
        await _task(task);
        final u = await _user(actor);
        if (body.trim().isEmpty) throw const RuleError('Введите комментарий');
        await db
            .into(db.comments)
            .insert(
              CommentsCompanion.insert(
                taskId: task,
                author: Value(actor),
                authorName: u.name,
                body: body.trim(),
                created: now,
              ),
            );
      });
  Future<void> deleteComment(int id, int actor) async {
    final n = await (db.delete(
      db.comments,
    )..where((c) => c.id.equals(id) & c.author.equals(actor))).go();
    if (n == 0) throw const RuleError('Удалить комментарий может только автор');
  }

  Future<void> attach(int task, File original, String name) async {
    await files.create(recursive: true);
    final dir = await files.createTemp('attachment-');
    final copy = File(p.join(dir.path, p.basename(name)));
    try {
      await original.copy(copy.path);
      await db.transaction(() async {
        await _task(task);
        await db
            .into(db.attachments)
            .insert(
              AttachmentsCompanion.insert(
                taskId: task,
                name: name,
                path: copy.path,
                created: now,
              ),
            );
      });
    } catch (_) {
      await dir.delete(recursive: true);
      rethrow;
    }
  }

  Stream<List<Task>> list(TaskFilter f) {
    final query = db.select(db.tasks)
      ..where((t) => f.trash ? t.deletedAt.isNotNull() : t.deletedAt.isNull());
    if (f.project != null) query.where((t) => t.projectId.equals(f.project!));
    if (f.assignee != null) query.where((t) => t.assignee.equals(f.assignee!));
    if (f.status != null) query.where((t) => t.status.equals(f.status!));
    if (f.priority != null) query.where((t) => t.priority.equals(f.priority!));
    if (f.search.trim().isNotEmpty) {
      // INSTR treats user input literally, including percent and underscore.
      final needle = f.search.trim().toLowerCase();
      query.where(
        (t) =>
            FunctionCallExpression<int>('instr', [
              FunctionCallExpression<String>('fold_text', [t.title]),
              Variable(needle),
            ]).isBiggerThanValue(0) |
            FunctionCallExpression<int>('instr', [
              FunctionCallExpression<String>('fold_text', [t.description]),
              Variable(needle),
            ]).isBiggerThanValue(0),
      );
    }
    final mode = f.descending ? OrderingMode.desc : OrderingMode.asc;
    query.orderBy([
      (t) => OrderingTerm(
        expression: f.byCreated ? t.created : t.deadline,
        mode: mode,
      ),
      (t) => OrderingTerm(expression: t.id, mode: mode),
    ]);
    query.limit(TaskFilter.size + 1, offset: TaskFilter.size * f.page);
    return query.watch();
  }

  Stream<Dashboard> dashboard(String today) {
    const sql = """
    WITH live AS (SELECT * FROM tasks WHERE deleted_at IS NULL),
    priority_names(label) AS (VALUES ('low'),('medium'),('high'),('critical'))
    SELECT 'projects' section,'' label,COUNT(*) n FROM projects
    UNION ALL SELECT 'tasks','',COUNT(*) FROM live
    UNION ALL SELECT 'done','',COUNT(*) FROM live WHERE status='done'
    UNION ALL SELECT 'open','',COUNT(*) FROM live WHERE status IN ('todo','inProgress')
    UNION ALL SELECT 'late','',COUNT(*) FROM live WHERE status IN ('todo','inProgress') AND deadline<?
    UNION ALL SELECT 'priority',p.label,COUNT(l.id) FROM priority_names p LEFT JOIN live l ON l.priority=p.label GROUP BY p.label
    UNION ALL SELECT 'person',u.name || ' · ' || u.email,COUNT(l.id) FROM users u LEFT JOIN live l ON l.assignee=u.id GROUP BY u.id
    UNION ALL SELECT 'progress',p.name,COALESCE(ROUND(100.0*SUM(CASE WHEN l.status='done' THEN 1 ELSE 0 END)/NULLIF(COUNT(l.id),0),1),0) FROM projects p LEFT JOIN live l ON l.project_id=p.id GROUP BY p.id
    """;
    return db
        .customSelect(
          sql,
          variables: [Variable(today)],
          readsFrom: {db.tasks, db.users, db.projects},
        )
        .watch()
        .map((rows) {
          int total(String key) => rows
              .firstWhere((r) => r.read<String>('section') == key)
              .read<int>('n');
          List<CountItem> items(String key) => [
            for (final r in rows.where((r) => r.read<String>('section') == key))
              (label: r.read<String>('label'), count: r.data['n'] as num),
          ];
          return Dashboard(
            total('projects'),
            total('tasks'),
            total('done'),
            total('open'),
            total('late'),
            items('priority'),
            items('person'),
            items('progress'),
          );
        });
  }
}
