import 'dart:async';
import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/api_service.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];
  List<Task> filteredTasks = [];

  bool isLoading = false;
  String searchQuery = "";

  final api = ApiService();
  Timer? _debounce;

  Future<void> loadTasks() async {
    try {
      isLoading = true;
      notifyListeners();

      tasks = await api.fetchTasks();
      filteredTasks = tasks;
    } catch (e) {
      print("LOAD ERROR: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await api.createTask(task);
      await loadTasks();
    } catch (e) {
      throw Exception("Failed to create task");
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await api.updateTask(task);
      await loadTasks();
    } catch (e) {
      throw Exception("Failed to update task");
    }
  }

  Future<void> deleteTask(int id) async {
    await api.deleteTask(id);
    await loadTasks();
  }

  void search(String query) {
    searchQuery = query;

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(Duration(milliseconds: 300), () {
      filteredTasks = tasks.where((task) {
        return task.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
      notifyListeners();
    });
  }
}