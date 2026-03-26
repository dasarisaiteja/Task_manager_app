import 'dart:async';
import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/api_service.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];
  List<Task> filteredTasks = [];

  final api = ApiService();
  Timer? _debounce;

  Future<void> loadTasks() async {
    tasks = await api.fetchTasks();
    filteredTasks = tasks;
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await api.createTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await api.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await api.deleteTask(id);
    await loadTasks();
  }

  void search(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(Duration(milliseconds: 300), () {
      filteredTasks = tasks.where((task) {
        return task.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
      notifyListeners();
    });
  }
}