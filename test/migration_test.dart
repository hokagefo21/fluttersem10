import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' as raw;
import 'package:taskflow/database/connection.dart';
import 'package:taskflow/database/database.dart';
import 'package:taskflow/repository/task_repository.dart';

void main() {
  test('миграция реального файла v1 в v2 и повторное открытие', () async {
    final temp = await Directory.systemTemp.createTemp('taskflow-migration');
    addTearDown(() => temp.delete(recursive: true));
    final file = File('${temp.path}/v1.sqlite'),
        legacy = raw.sqlite3.open(file.path);
    legacy.execute(File('test/fixtures/schema_v1.sql').readAsStringSync());
    legacy.execute(
      """INSERT INTO users VALUES(1,'Test','a@example.org','2025-01-01');
      INSERT INTO projects VALUES(1,'Legacy','','2025-01-01',NULL,'active');
      INSERT INTO project_members VALUES(1,1,'Owner');
      INSERT INTO tasks(id,title,description,project_id,assignee,status,deadline,created,updated)
      VALUES(9,'Legacy task','keep',1,1,'todo','2025-02-01',1,1);
      INSERT INTO task_history(task_id,kind,new_status,actor,actor_name,created) VALUES(9,'created','todo',1,'Test',1);""",
    );
    legacy.dispose();
    for (var i = 0; i < 2; i++) {
      final migrated = TaskDatabase(
        NativeDatabase(file, setup: configureConnection),
      );
      try {
        final repo = TaskRepository(migrated, temp),
            t = (await repo.task(9).first).single;
        expect((t.priority, t.description, t.assignee), ('medium', 'keep', 1));
        expect((await repo.history(9).first).single.actorName, 'Test');
        expect(
          (await migrated.customSelect('PRAGMA user_version').getSingle())
              .data
              .values
              .single,
          2,
        );
        expect(
          await migrated.customSelect('PRAGMA foreign_key_check').get(),
          isEmpty,
        );
      } finally {
        await migrated.close();
      }
    }
  });
}
