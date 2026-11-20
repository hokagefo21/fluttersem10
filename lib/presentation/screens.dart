import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import '../database/database.dart';
import '../model/task_model.dart';
import '../state/workspace.dart';
import 'common.dart';
import 'editors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tab = 0;
  @override
  Widget build(BuildContext c) {
    final w = Scope.of(c);
    final titles = ['Проекты', 'Задачи', 'Люди', 'Статистика'];
    return Scaffold(
      appBar: AppBar(
        title: Text('TaskFlow · ${titles[tab]}'),
        actions: [
          PopupMenuButton<int>(
            tooltip: 'Текущий пользователь',
            icon: const Icon(Icons.account_circle_outlined),
            onSelected: w.selectActor,
            itemBuilder: (_) => [
              for (final u in w.people)
                CheckedPopupMenuItem(
                  value: u.id,
                  checked: w.actor == u.id,
                  child: Text('${u.name} · ${u.email}'),
                ),
            ],
          ),
          IconButton(
            tooltip: 'Корзина',
            onPressed: () => openPage(c, const TaskPage(trash: true)),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: w.error != null
          ? empty('Ошибка: ${w.error}')
          : !w.usersReady || !w.projectsReady
          ? const Center(child: CircularProgressIndicator())
          : switch (tab) {
              0 => ProjectList(w.projects),
              1 => const TaskList(),
              2 => PeopleList(w.people),
              _ => const StatsScreen(),
            },
      floatingActionButton: tab == 3
          ? null
          : FloatingActionButton.extended(
              onPressed: () => switch (tab) {
                0 => projectEditor(c),
                1 => taskEditor(c),
                _ => userEditor(c),
              },
              icon: const Icon(Icons.add),
              label: Text(['Проект', 'Задача', 'Пользователь'][tab]),
            ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (i) => setState(() => tab = i),
        destinations: [
          for (final e in [
            (Icons.folder_outlined, 'Проекты'),
            (Icons.checklist, 'Задачи'),
            (Icons.group_outlined, 'Люди'),
            (Icons.bar_chart, 'Статистика'),
          ])
            NavigationDestination(icon: Icon(e.$1), label: e.$2),
        ],
      ),
    );
  }
}

class ProjectList extends StatelessWidget {
  final List<Project> rows;
  const ProjectList(this.rows, {super.key});
  @override
  Widget build(BuildContext c) => rows.isEmpty
      ? empty(
          'Создайте первый проект. Участников можно добавить в его карточке.',
        )
      : ListView.builder(
          padding: const EdgeInsets.only(bottom: 88),
          itemCount: rows.length,
          itemBuilder: (_, i) {
            final p = rows[i];
            return ListTile(
              leading: const Icon(Icons.folder_outlined),
              title: Text(p.name),
              subtitle: Text('${projectStates[p.status]} · ${p.created}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => openPage(c, ProjectPage(p.id)),
            );
          },
        );
}

class PeopleList extends StatelessWidget {
  final List<User> rows;
  const PeopleList(this.rows, {super.key});
  @override
  Widget build(BuildContext c) {
    final w = Scope.of(c);
    return rows.isEmpty
        ? empty(
            'Добавьте первого пользователя. Его можно будет назначить исполнителем.',
          )
        : ListView.builder(
            padding: const EdgeInsets.only(bottom: 90),
            itemCount: rows.length,
            itemBuilder: (_, i) {
              final u = rows[i];
              return ListTile(
                title: Text(u.name),
                subtitle: Text('${u.email}\nРегистрация · ${u.registered}'),
                isThreeLine: true,
                leading: Icon(
                  w.actor == u.id ? Icons.account_circle : Icons.person_outline,
                ),
                onTap: () => openPage(c, TaskPage(user: u.id)),
                trailing: PopupMenuButton<String>(
                  onSelected: (v) {
                    if (v == 'edit') userEditor(c, u);
                    if (v == 'actor') w.selectActor(u.id);
                    if (v == 'delete') {
                      confirm(
                        c,
                        'Удалить пользователя ${u.name}?',
                        () => w.repo.deleteUser(u.id),
                      );
                    }
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(
                      value: 'actor',
                      child: Text('Действовать от этого имени'),
                    ),
                    PopupMenuItem(value: 'edit', child: Text('Изменить')),
                    PopupMenuItem(value: 'delete', child: Text('Удалить')),
                  ],
                ),
              );
            },
          );
  }
}

class ProjectPage extends StatelessWidget {
  final int id;
  const ProjectPage(this.id, {super.key});
  @override
  Widget build(BuildContext c) {
    final w = Scope.of(c), p = w.projects.where((p) => p.id == id).firstOrNull;
    if (p == null) {
      return Scaffold(appBar: AppBar(), body: empty('Проект удалён'));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(p.name),
        actions: [
          IconButton(
            tooltip: 'Изменить проект',
            onPressed: () => projectEditor(c, p),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Удалить проект',
            onPressed: () => confirm(
              c,
              'Удалить проект со всеми задачами и вложениями?',
              () async {
                await w.repo.deleteProject(id);
                if (c.mounted) Navigator.pop(c);
              },
            ),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            projectStates[p.status]!,
            style: Theme.of(c).textTheme.labelLarge,
          ),
          if (p.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(p.description),
            ),
          Text('Создан · ${p.created}'),
          if (p.finish != null) Text('Завершение · ${p.finish}'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: FilledButton.tonalIcon(
              onPressed: () => openPage(c, TaskPage(project: id)),
              icon: const Icon(Icons.checklist),
              label: const Text('Задачи проекта'),
            ),
          ),
          Live(
            w.repo.members(id),
            (ms) => Column(
              children: [
                ListTile(
                  title: const Text('Участники'),
                  trailing: IconButton(
                    tooltip: 'Добавить участника',
                    onPressed: () => memberEditor(c, id, ms),
                    icon: const Icon(Icons.person_add_alt),
                  ),
                ),
                for (final m in ms)
                  ListTile(
                    title: Text(w.person(m.userId)),
                    subtitle: Text(m.role),
                    onTap: () => memberEditor(c, id, ms, m),
                    trailing: IconButton(
                      tooltip: 'Убрать участника',
                      onPressed: () => confirm(
                        c,
                        'Убрать участника?',
                        () => w.repo.removeMember(id, m.userId),
                      ),
                      icon: const Icon(Icons.person_remove_outlined),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TaskPage extends StatelessWidget {
  final int? project, user;
  final bool trash;
  const TaskPage({super.key, this.project, this.user, this.trash = false});
  @override
  Widget build(BuildContext c) {
    final w = Scope.of(c);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          trash
              ? 'Корзина'
              : project != null
              ? w.project(project!)
              : w.person(user),
        ),
      ),
      body: TaskList(project: project, user: user, trash: trash),
      floatingActionButton: trash || user != null
          ? null
          : FloatingActionButton.extended(
              onPressed: () => taskEditor(c, projectId: project),
              icon: const Icon(Icons.add),
              label: const Text('Задача'),
            ),
    );
  }
}

class TaskList extends StatefulWidget {
  final int? project, user;
  final bool trash;
  const TaskList({super.key, this.project, this.user, this.trash = false});
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late final f = TaskFilter()
    ..project = widget.project
    ..assignee = widget.user
    ..trash = widget.trash;
  final search = TextEditingController();
  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  void change(VoidCallback op) => setState(() {
    op();
    f.page = 0;
  });
  @override
  Widget build(BuildContext c) {
    final w = Scope.of(c);
    return Live(
      w.repo.list(f),
      (rows) => ListView(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 100),
        children: [
          TextField(
            controller: search,
            onChanged: (v) => change(() => f.search = v),
            decoration: const InputDecoration(
              labelText: 'Поиск по названию и описанию',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          ExpansionTile(
            title: const Text('Фильтры и сортировка'),
            childrenPadding: const EdgeInsets.all(8),
            children: [
              choices(
                'Статус',
                f.status,
                statuses,
                (v) => change(() => f.status = v),
                all: true,
              ),
              const SizedBox(height: 8),
              choices(
                'Приоритет',
                f.priority,
                priorities,
                (v) => change(() => f.priority = v),
                all: true,
              ),
              const SizedBox(height: 8),
              if (widget.user == null)
                choices(
                  'Исполнитель',
                  f.assignee,
                  {for (final u in w.people) u.id: u.name},
                  (v) => change(() => f.assignee = v),
                  all: true,
                ),
              const SizedBox(height: 8),
              choices(
                'Сортировать',
                f.byCreated ? 'created' : 'deadline',
                {'deadline': 'По дедлайну', 'created': 'По созданию'},
                (v) => change(() => f.byCreated = v == 'created'),
              ),
              SwitchListTile(
                title: const Text('По убыванию'),
                value: f.descending,
                onChanged: (v) => change(() => f.descending = v),
              ),
              TextButton(
                onPressed: () => change(() {
                  search.clear();
                  f.search = '';
                  f.status = null;
                  f.priority = null;
                  f.assignee = widget.user;
                  f.byCreated = false;
                  f.descending = false;
                }),
                child: const Text('Сбросить'),
              ),
            ],
          ),
          if (rows.isEmpty)
            empty(f.trash ? 'Корзина пуста' : 'Задач по этим условиям нет'),
          for (final t in rows.take(TaskFilter.size))
            ListTile(
              title: Text(t.title),
              subtitle: Text(
                '${w.project(t.projectId)} · ${w.person(t.assignee)}\n${statuses[t.status]} · ${priorities[t.priority]} · ${t.deadline}',
              ),
              isThreeLine: true,
              onTap: f.trash ? null : () => openPage(c, DetailPage(t.id)),
              trailing: f.trash
                  ? PopupMenuButton<String>(
                      onSelected: (v) {
                        if (v == 'restore') {
                          act(c, () => w.repo.restore(t.id));
                        } else {
                          confirm(
                            c,
                            'Удалить задачу окончательно?',
                            () => w.repo.purge(t.id),
                          );
                        }
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(
                          value: 'restore',
                          child: Text('Восстановить'),
                        ),
                        PopupMenuItem(
                          value: 'purge',
                          child: Text('Удалить навсегда'),
                        ),
                      ],
                    )
                  : const Icon(Icons.chevron_right),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                tooltip: 'Предыдущая страница',
                onPressed: f.page == 0 ? null : () => setState(() => f.page--),
                icon: const Icon(Icons.chevron_left),
              ),
              Text('Страница ${f.page + 1}'),
              IconButton(
                tooltip: 'Следующая страница',
                onPressed: rows.length <= TaskFilter.size
                    ? null
                    : () => setState(() => f.page++),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final int id;
  const DetailPage(this.id, {super.key});
  @override
  Widget build(BuildContext c) {
    final w = Scope.of(c), r = w.repo, actor = w.actor;
    return Live(r.task(id), (rows) {
      final t = rows.firstOrNull;
      if (t == null || t.deletedAt != null) {
        return Scaffold(
          appBar: AppBar(),
          body: empty('Задача в корзине или удалена'),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text('Карточка задачи'),
          actions: [
            IconButton(
              tooltip: 'Изменить задачу',
              onPressed: () => taskEditor(c, task: t),
              icon: const Icon(Icons.edit_outlined),
            ),
            IconButton(
              tooltip: 'В корзину',
              onPressed: () =>
                  confirm(c, 'Переместить задачу в корзину?', () async {
                    await r.trash(id);
                    if (c.mounted) Navigator.pop(c);
                  }),
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(t.title, style: Theme.of(c).textTheme.headlineSmall),
            if (t.description.isNotEmpty) Text(t.description),
            const Divider(),
            Text('Проект · ${w.project(t.projectId)}'),
            Text('Исполнитель · ${w.person(t.assignee)}'),
            Text('${statuses[t.status]} · ${priorities[t.priority]} приоритет'),
            Text('Дедлайн · ${t.deadline}'),
            Text('Создана · ${timestamp(t.created)}'),
            Text('Изменена · ${timestamp(t.updated)}'),
            const Divider(),
            Text('История', style: Theme.of(c).textTheme.titleMedium),
            Live(
              r.history(id),
              (events) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final h in events)
                    ListTile(
                      dense: true,
                      title: Text(switch (h.kind) {
                        'assignee' =>
                          'Исполнитель: ${h.oldAssignee ?? "—"} → ${h.newAssignee}',
                        'created' => 'Создана · ${statuses[h.newStatus]}',
                        _ =>
                          '${h.kind == "undo" ? "Отмена · " : ""}${statuses[h.oldStatus]} → ${statuses[h.newStatus]}',
                      }),
                      subtitle: Text(
                        '${h.actorName} · ${timestamp(h.created)}',
                      ),
                    ),
                  if (events.any(
                    (e) =>
                        e.kind == 'status' &&
                        !events.any((u) => u.undoOf == e.id),
                  ))
                    TextButton.icon(
                      onPressed: actor == null
                          ? null
                          : () => act(c, () => r.undo(id, actor)),
                      icon: const Icon(Icons.undo),
                      label: const Text('Отменить изменение статуса'),
                    ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Комментарии'),
              trailing: IconButton(
                tooltip: 'Добавить комментарий',
                icon: const Icon(Icons.add_comment_outlined),
                onPressed: actor == null
                    ? null
                    : () {
                        var body = '';
                        editor(
                          c,
                          'Комментарий · ${w.person(actor)}',
                          (_, set) => [
                            input('Текст', body, (v) => body = v, lines: 3),
                          ],
                          () => r.comment(id, actor, body),
                        );
                      },
              ),
            ),
            Live(
              r.comments(id),
              (items) => Column(
                children: [
                  for (final a in items)
                    ListTile(
                      title: Text(a.body),
                      subtitle: Text(
                        '${a.authorName} · ${timestamp(a.created)}',
                      ),
                      trailing: actor != null && a.author == actor
                          ? IconButton(
                              tooltip: 'Удалить комментарий',
                              onPressed: () => confirm(
                                c,
                                'Удалить комментарий?',
                                () => r.deleteComment(a.id, actor),
                              ),
                              icon: const Icon(Icons.close),
                            )
                          : null,
                    ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Вложения'),
              trailing: IconButton(
                tooltip: 'Прикрепить файл',
                icon: const Icon(Icons.attach_file),
                onPressed: () => act(c, () async {
                  final file = await openFile();
                  if (file != null) {
                    await r.attach(id, File(file.path), file.name);
                  }
                }),
              ),
            ),
            Live(
              r.attachments(id),
              (items) => Column(
                children: [
                  for (final a in items)
                    ListTile(
                      leading: const Icon(Icons.insert_drive_file_outlined),
                      title: Text(a.name),
                      subtitle: SelectableText(
                        '${timestamp(a.created)}\n${a.path}',
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});
  @override
  Widget build(BuildContext c) => Live(
    Scope.of(c).repo.dashboard(day(DateTime.now())),
    (d) => ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final e in [
          ('Проектов', d.projects),
          ('Задач', d.tasks),
          ('Завершено', d.done),
          ('Не завершено', d.open),
          ('Просрочено', d.late),
        ])
          ListTile(
            title: Text(e.$1),
            trailing: Text('${e.$2}', style: Theme.of(c).textTheme.titleLarge),
          ),
        for (final section in [
          ('По приоритету', d.priorities),
          ('По исполнителю', d.people),
          ('Выполнение проектов', d.progress),
        ]) ...[
          const Divider(),
          Text(section.$1, style: Theme.of(c).textTheme.titleMedium),
          for (final item in section.$2)
            ListTile(
              title: Text(priorities[item.label] ?? item.label),
              trailing: Text(
                '${item.count}${section.$2 == d.progress ? "%" : ""}',
              ),
            ),
        ],
      ],
    ),
  );
}
