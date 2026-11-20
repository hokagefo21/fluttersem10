import 'package:drift/drift.dart';
part 'database.g.dart';

@DriftDatabase(include: {'schema.drift'})
class TaskDatabase extends _$TaskDatabase {
  TaskDatabase(super.executor);
  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from == 1 && to == 2) {
        await transaction(() async {
          await m.addColumn(tasks, tasks.priority);
          await m.createIndex(taskPriorityDue);
        });
      } else {
        throw StateError('Неподдерживаемая версия базы: $from → $to');
      }
    },
    beforeOpen: (_) async => customStatement('PRAGMA foreign_keys = ON'),
  );
}
