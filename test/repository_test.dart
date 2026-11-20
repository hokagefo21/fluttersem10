import 'dart:io';
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/database/connection.dart';
import 'package:taskflow/database/database.dart';
import 'package:taskflow/model/task_model.dart';
import 'package:taskflow/repository/task_repository.dart';

void main() {
  late Directory temp;
  late TaskDatabase db;
  late TaskRepository r;
  late int alice, bob, project;
  const due = '2026-02-20';
  setUp(() async {
    temp = await Directory.systemTemp.createTemp('taskflow-test');
    db = TaskDatabase(openTestDatabase());
    r = TaskRepository(db, temp);
    alice = await r.saveUser('Алия', 'aliya@example.org', '2026-01-01');
    bob = await r.saveUser('Бек', 'bek@example.org', '2026-01-01');
    project = await r.saveProject(
      'Мобильное приложение',
      'Описание',
      '2026-01-01',
      null,
      'active',
    );
    await r.member(project, alice, 'Owner');
  });
  tearDown(() async {
    await db.close();
    await temp.delete(recursive: true);
  });
  Future<int> save({
    int? id,
    int? who,
    String title = 'Дизайн',
    String desc = 'Прототип',
    String status = 'todo',
    String priority = 'medium',
    String deadline = due,
    int? projectId,
  }) => r.saveTask(
    TaskInput(
      title: title,
      description: desc,
      project: projectId ?? project,
      assignee: who ?? alice,
      deadline: deadline,
      status: status,
      priority: priority,
    ),
    alice,
    id: id,
  );
  test('создание, редактирование и удаление пользователя', () async {
    await r.saveUser('Бекжан', 'bek2@example.org', due, id: bob);
    expect(
      (await r.users().first).firstWhere((u) => u.id == bob).name,
      'Бекжан',
    );
    await r.deleteUser(bob);
    expect(await r.users().first, hasLength(1));
  });
  test('уникальный email без зависимости от регистра', () async {
    await expectLater(
      r.saveUser('А', ' ALIYA@example.org ', due),
      throwsA(isA<RuleError>()),
    );
  });
  test('проект сохраняет описание, дедлайн и статус', () async {
    await r.saveProject('Архив', 'Готово', due, due, 'archived', id: project);
    final p = (await r.projects().first).single;
    expect((p.description, p.status, p.finish), ('Готово', 'archived', due));
  });
  test('дата окончания не может быть раньше даты создания', () async {
    await expectLater(
      r.saveProject('P', '', due, '2025-01-01', 'active'),
      throwsA(isA<RuleError>()),
    );
  });
  test('роли и уникальность участия', () async {
    await r.member(project, bob, 'Member');
    await r.member(project, bob, 'Admin', edit: true);
    expect((await r.members(project).first).last.role, 'Admin');
    await expectLater(
      r.member(project, bob, 'Member'),
      throwsA(isA<RuleError>()),
    );
    await r.removeMember(project, bob);
    expect(await r.members(project).first, hasLength(1));
  });
  test('задача создаётся вместе с историей и автором', () async {
    final id = await save();
    final h = (await r.history(id).first).single;
    expect((h.kind, h.actor, h.newStatus), ('created', alice, 'todo'));
    expect((await r.task(id).first).single.priority, 'medium');
  });
  test('задача без проекта и участника запрещена', () async {
    await expectLater(save(projectId: 999), throwsA(isA<RuleError>()));
    await expectLater(save(who: bob), throwsA(isA<RuleError>()));
  });
  test('ошибка при вставке истории откатывает создание задачи', () async {
    await db.customStatement(
      "CREATE TRIGGER fail_event BEFORE INSERT ON task_history BEGIN SELECT RAISE(ABORT,'test'); END",
    );
    await expectLater(save(), throwsA(anything));
    expect(await r.list(TaskFilter()).first, isEmpty);
  });
  test('смена статуса, исполнителя и атомарный откат', () async {
    final id = await save();
    await r.member(project, bob, 'Admin');
    await db.customStatement(
      "CREATE TRIGGER fail_move BEFORE INSERT ON task_history WHEN NEW.kind='assignee' BEGIN SELECT RAISE(ABORT,'test'); END",
    );
    await expectLater(
      save(id: id, who: bob, status: 'inProgress'),
      throwsA(anything),
    );
    var t = (await r.task(id).first).single;
    expect((t.assignee, t.status), (alice, 'todo'));
    expect(await r.history(id).first, hasLength(1));
    await db.customStatement('DROP TRIGGER fail_move');
    await save(id: id, who: bob, status: 'inProgress');
    final events = await r.history(id).first;
    expect(events.map((e) => e.kind), ['assignee', 'status', 'created']);
    expect(
      (events.first.oldAssignee, events.first.newAssignee),
      ('Алия', 'Бек'),
    );
  });
  test(
    'отмена изменений по порядку без повторной отмены одного события',
    () async {
      final id = await save();
      await save(id: id, status: 'inProgress');
      await save(id: id, status: 'done');
      await r.undo(id, bob);
      expect((await r.task(id).first).single.status, 'inProgress');
      await r.undo(id, bob);
      expect((await r.task(id).first).single.status, 'todo');
      await expectLater(r.undo(id, bob), throwsA(isA<RuleError>()));
      expect((await r.history(id).first).first.actor, bob);
    },
  );
  test('лимит трёх открытых задач, другой день и закрытые задачи', () async {
    final results = await Future.wait(
      List.generate(4, (_) async {
        try {
          await save();
          return true;
        } on RuleError {
          return false;
        }
      }),
    );
    expect(results.where((ok) => ok), hasLength(3));
    await save(deadline: '2026-02-21');
    await save(status: 'done');
  });
  test(
    'запрет удаления исполнителя открытой задачи, хранение имени в истории',
    () async {
      final id = await save();
      await expectLater(r.deleteUser(alice), throwsA(isA<RuleError>()));
      await expectLater(
        r.removeMember(project, alice),
        throwsA(isA<RuleError>()),
      );
      await save(id: id, status: 'done');
      await r.deleteUser(alice);
      expect((await r.task(id).first).single.assignee, isNull);
      expect((await r.history(id).first).first.actorName, 'Алия');
    },
  );
  test(
    'комментарии существуют только у задач, удалить может только автор',
    () async {
      final id = await save();
      await r.comment(id, bob, 'Проверено');
      final note = (await r.comments(id).first).single;
      await expectLater(
        r.deleteComment(note.id, alice),
        throwsA(isA<RuleError>()),
      );
      await r.deleteComment(note.id, bob);
      expect(await r.comments(id).first, isEmpty);
      await expectLater(r.comment(3000, bob, '?'), throwsA(isA<RuleError>()));
    },
  );
  test(
    'корзина скрывает задачу и сохраняет историю для восстановления',
    () async {
      final id = await save();
      await r.trash(id);
      expect(await r.list(TaskFilter()).first, isEmpty);
      expect((await r.list(TaskFilter()..trash = true).first).single.id, id);
      await r.restore(id);
      expect((await r.list(TaskFilter()).first).single.id, id);
      expect(await r.history(id).first, hasLength(1));
    },
  );
  test('восстановление уважает лимит', () async {
    final id = await save();
    await r.trash(id);
    for (var i = 0; i < 3; i++) {
      await save();
    }
    await expectLater(r.restore(id), throwsA(isA<RuleError>()));
  });
  test(
    'файл копируется, метаданные и зависимости удаляются с задачей',
    () async {
      final id = await save(), source = File('${temp.path}/notes.txt');
      await source.writeAsString('demo');
      await r.attach(id, source, 'notes.txt');
      await r.comment(id, bob, 'ok');
      final a = (await r.attachments(id).first).single;
      await source.delete();
      expect(await File(a.path).readAsString(), 'demo');
      await r.trash(id);
      await r.purge(id);
      expect(await r.history(id).first, isEmpty);
      expect(await r.comments(id).first, isEmpty);
      expect(await r.attachments(id).first, isEmpty);
      expect(await File(a.path).exists(), false);
    },
  );
  test('каскад при удалении проекта', () async {
    final id = await save();
    await r.comment(id, bob, 'ok');
    await r.deleteProject(project);
    expect(await r.task(id).first, isEmpty);
    expect(await r.history(id).first, isEmpty);
    expect(await r.comments(id).first, isEmpty);
    expect(await r.members(project).first, isEmpty);
  });
  test(
    'статистика SQL учитывает корзину, нулевые значения и просрочку',
    () async {
      await save(status: 'done', priority: 'critical');
      await save(priority: 'high');
      final id = await save();
      await r.trash(id);
      await r.saveProject('Пустой', '', '2026-01-02', null, 'active');
      final d = await r.dashboard('2026-03-01').first;
      expect([d.projects, d.tasks, d.done, d.open, d.late], [2, 2, 1, 1, 1]);
      expect(d.progress.map((a) => a.count), containsAll([50, 0]));
      expect(d.people.map((a) => a.count), containsAll([2, 0]));
      expect(d.priorities.firstWhere((a) => a.label == 'critical').count, 1);
    },
  );
  test(
    'поиск по описанию и названию, кириллица и буквальный процент',
    () async {
      final id = await save(desc: 'Отчёт 100%', priority: 'critical');
      await save(title: 'Идея', desc: 'Другое');
      final f = TaskFilter()
        ..search = 'ОТЧЁТ 100%'
        ..priority = 'critical'
        ..assignee = alice
        ..status = 'todo'
        ..project = project;
      expect((await r.list(f).first).single.id, id);
      f.search = 'дизайн';
      expect((await r.list(f).first).single.id, id);
      f.search = '100_';
      expect(await r.list(f).first, isEmpty);
    },
  );
  test('пагинация и сортировка со стабильным порядком', () async {
    for (var i = 0; i < 30; i++) {
      await save(
        status: 'done',
        deadline: i.isEven ? '2026-02-01' : '2026-02-02',
      );
    }
    final f = TaskFilter(),
        first = (await r.list(f).first).take(TaskFilter.size).toList();
    final second = await r.list(f..page = 1).first;
    expect(second, hasLength(5));
    expect({
      ...first.map((t) => t.id),
      ...second.map((t) => t.id),
    }, hasLength(30));
    expect(first.first.deadline, '2026-02-01');
    f
      ..page = 0
      ..byCreated = true
      ..descending = true;
    expect((await r.list(f).first).first.id, 30);
  });
  test('watch публикует запись после коммита', () async {
    final rows = StreamIterator(r.list(TaskFilter()));
    addTearDown(rows.cancel);
    expect(await rows.moveNext(), isTrue);
    expect(rows.current, isEmpty);
    await save();
    expect(await rows.moveNext(), isTrue);
    expect(rows.current, hasLength(1));
  });
}
