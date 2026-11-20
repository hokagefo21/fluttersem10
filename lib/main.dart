import 'dart:io';
import 'database/connection.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'database/database.dart';
import 'repository/task_repository.dart';
import 'state/workspace.dart';
import 'presentation/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final db = TaskDatabase(
    openFileDatabase(File(p.join(dir.path, 'taskflow.sqlite'))),
  );
  runApp(
    TaskFlow(
      Workspace(
        TaskRepository(db, Directory(p.join(dir.path, 'taskflow_files'))),
      ),
    ),
  );
}

class TaskFlow extends StatelessWidget {
  final Workspace state;
  const TaskFlow(this.state, {super.key});
  @override
  Widget build(BuildContext context) => Scope(
    state,
    child: MaterialApp(
      title: 'TaskFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff17685c)),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          isDense: true,
        ),
      ),
      home: const HomeScreen(),
    ),
  );
}
