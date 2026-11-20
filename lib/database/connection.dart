import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite3/sqlite3.dart' as native;

void configureConnection(native.Database db) {
  db.createFunction(
    functionName: 'fold_text',
    argumentCount: const native.AllowedArgumentCount(1),
    deterministic: true,
    function: (args) => (args.single as String).toLowerCase(),
  );
}

QueryExecutor openFileDatabase(File file) =>
    NativeDatabase.createInBackground(file, setup: configureConnection);
QueryExecutor openTestDatabase() =>
    NativeDatabase.memory(setup: configureConnection);
