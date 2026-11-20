import 'package:flutter/material.dart';
import '../database/database.dart';
import '../model/task_model.dart';
import '../state/workspace.dart';
import 'common.dart';

Future<void> userEditor(BuildContext c, [User? u]) {
  final w = Scope.of(c);
  var name = u?.name ?? '',
      email = u?.email ?? '',
      date = u?.registered ?? day(DateTime.now());
  return editor(
    c,
    u == null ? 'Новый пользователь' : 'Изменить пользователя',
    (ctx, set) => [
      input('Имя', name, (v) => name = v),
      input('Email', email, (v) => email = v),
      dateField(ctx, 'Регистрация', date, (v) => set(() => date = v!)),
    ],
    () async {
      await w.repo.saveUser(name, email, date, id: u?.id);
    },
  );
}

Future<void> projectEditor(BuildContext c, [Project? p]) {
  final w = Scope.of(c);
  var name = p?.name ?? '',
      desc = p?.description ?? '',
      date = p?.created ?? day(DateTime.now()),
      status = p?.status ?? 'active';
  String? finish = p?.finish;
  return editor(
    c,
    p == null ? 'Новый проект' : 'Изменить проект',
    (ctx, set) => [
      input('Название', name, (v) => name = v),
      input('Описание', desc, (v) => desc = v, lines: 2),
      dateField(ctx, 'Создан', date, (v) => set(() => date = v!)),
      dateField(
        ctx,
        'Завершение',
        finish,
        (v) => set(() => finish = v),
        optional: true,
      ),
      choices(
        'Статус проекта',
        status,
        projectStates,
        (v) => set(() => status = v!),
      ),
    ],
    () async {
      await w.repo.saveProject(name, desc, date, finish, status, id: p?.id);
    },
  );
}

Future<void> memberEditor(
  BuildContext c,
  int project,
  List<ProjectMember> existing, [
  ProjectMember? member,
]) async {
  final w = Scope.of(c);
  final options = {
    for (final u in w.people.where(
      (u) => member != null
          ? u.id == member.userId
          : !existing.any((m) => m.userId == u.id),
    ))
      u.id: '${u.name} · ${u.email}',
  };
  if (options.isEmpty) {
    message(c, 'Сначала добавьте пользователя в разделе «Люди»');
    return;
  }
  var user = member?.userId ?? options.keys.first,
      role = member?.role ?? 'Member';
  await editor(
    c,
    member == null ? 'Добавить участника' : 'Роль участника',
    (ctx, set) => [
      choices('Пользователь', user, options, (v) => set(() => user = v!)),
      choices('Роль', role, {
        for (final r in roles) r: r,
      }, (v) => set(() => role = v!)),
    ],
    () => w.repo.member(project, user, role, edit: member != null),
  );
}

Future<void> taskEditor(BuildContext c, {int? projectId, Task? task}) async {
  final w = Scope.of(c);
  final actor = w.actor;
  if (actor == null || w.projects.isEmpty) {
    message(c, 'Для задачи нужны пользователь, проект и участник проекта');
    return;
  }
  var project = task?.projectId ?? projectId ?? w.projects.first.id;
  int? assignee = task?.assignee;
  var title = task?.title ?? '',
      desc = task?.description ?? '',
      due = task?.deadline ?? day(DateTime.now());
  var status = task?.status ?? 'todo', priority = task?.priority ?? 'medium';
  await editor(
    c,
    task == null ? 'Новая задача' : 'Изменить задачу',
    (ctx, set) => [
      if (task == null)
        choices(
          'Проект',
          project,
          {for (final p in w.projects) p.id: p.name},
          (v) => set(() {
            project = v!;
            assignee = null;
          }),
        ),
      input('Название', title, (v) => title = v),
      input('Описание', desc, (v) => desc = v, lines: 2),
      Live(w.repo.members(project), (ms) {
        final opts = {for (final m in ms) m.userId: w.person(m.userId)};
        return Column(
          children: [
            choices(
              'Исполнитель',
              assignee,
              opts,
              (v) => set(() => assignee = v),
            ),
            if (opts.isEmpty)
              const Text('Добавьте участника в карточке проекта'),
          ],
        );
      }, key: ValueKey(project)),
      choices('Статус', status, statuses, (v) => set(() => status = v!)),
      choices(
        'Приоритет',
        priority,
        priorities,
        (v) => set(() => priority = v!),
      ),
      dateField(ctx, 'Дедлайн', due, (v) => set(() => due = v!)),
    ],
    () async {
      if (assignee == null) throw const RuleError('Выберите исполнителя');
      await w.repo.saveTask(
        TaskInput(
          title: title,
          description: desc,
          project: project,
          assignee: assignee!,
          deadline: due,
          status: status,
          priority: priority,
        ),
        actor,
        id: task?.id,
      );
    },
  );
}
