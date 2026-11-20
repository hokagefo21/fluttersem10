import 'dart:async';
import 'package:flutter/material.dart';
import '../database/database.dart';
import '../repository/task_repository.dart';

class Workspace extends ChangeNotifier {
  final TaskRepository repo;
  List<User> people = [];
  List<Project> projects = [];
  int? actor;
  Object? error;
  bool usersReady = false, projectsReady = false;
  late final List<StreamSubscription<dynamic>> _subscriptions;
  Workspace(this.repo) {
    _subscriptions = [
      repo.users().listen((rows) {
        people = rows;
        if (!rows.any((u) => u.id == actor)) actor = rows.firstOrNull?.id;
        usersReady = true;
        notifyListeners();
      }, onError: _failed),
      repo.projects().listen((rows) {
        projects = rows;
        projectsReady = true;
        notifyListeners();
      }, onError: _failed),
    ];
  }
  void _failed(Object e) {
    error = e;
    notifyListeners();
  }

  void selectActor(int id) {
    actor = id;
    notifyListeners();
  }

  String person(int? id) =>
      people.where((u) => u.id == id).firstOrNull?.name ?? 'Без исполнителя';
  String project(int id) =>
      projects.where((p) => p.id == id).firstOrNull?.name ?? 'Проект удалён';
  @override
  void dispose() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    super.dispose();
  }
}

class Scope extends InheritedNotifier<Workspace> {
  const Scope(Workspace state, {required super.child, super.key})
    : super(notifier: state);
  static Workspace of(BuildContext c) =>
      c.dependOnInheritedWidgetOfExactType<Scope>()!.notifier!;
}
