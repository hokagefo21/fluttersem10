const statuses = {
  'todo': 'К выполнению',
  'inProgress': 'В работе',
  'done': 'Готово',
  'cancelled': 'Отменена',
};
const priorities = {
  'low': 'Низкий',
  'medium': 'Средний',
  'high': 'Высокий',
  'critical': 'Критический',
};
const projectStates = {
  'active': 'Активный',
  'completed': 'Завершён',
  'archived': 'В архиве',
};
const roles = ['Owner', 'Admin', 'Member'];
String day(DateTime d) => d.toIso8601String().substring(0, 10);
String timestamp(int ms) => DateTime.fromMillisecondsSinceEpoch(
  ms,
).toLocal().toString().substring(0, 16);
String checkedDay(String value) {
  final date = DateTime.tryParse(value);
  if (date == null || day(date) != value) {
    throw const FormatException('Некорректная дата');
  }
  return value;
}

class TaskInput {
  final String title, description, deadline, priority, status;
  final int project, assignee;
  const TaskInput({
    required this.title,
    this.description = '',
    required this.project,
    required this.assignee,
    required this.deadline,
    this.priority = 'medium',
    this.status = 'todo',
  });
}

class TaskFilter {
  String search = '';
  String? status, priority;
  int? assignee, project;
  bool byCreated = false, descending = false, trash = false;
  int page = 0;
  static const size = 25;
}

typedef CountItem = ({String label, num count});

class Dashboard {
  final int projects, tasks, done, open, late;
  final List<CountItem> priorities, people, progress;
  const Dashboard(
    this.projects,
    this.tasks,
    this.done,
    this.open,
    this.late,
    this.priorities,
    this.people,
    this.progress,
  );
}

class RuleError implements Exception {
  final String message;
  const RuleError(this.message);
  @override
  String toString() => message;
}
