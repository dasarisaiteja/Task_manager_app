import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class ApiService {
  
  final String baseUrl = "http://127.0.0.1:8000/api/tasks/";

  Future<List<Task>> fetchTasks() async {
    final res = await http.get(Uri.parse(baseUrl));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data.map<Task>((e) => Task.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load tasks");
    }
  }

  Future<void> createTask(Task task) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(task.toJson()),
    );

    if (res.statusCode != 201) {
      throw Exception("Failed to create task");
    }
  }

  Future<void> updateTask(Task task) async {
    final res = await http.put(
      Uri.parse("$baseUrl${task.id}/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(task.toJson()),
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to update task");
    }
  }

  Future<void> deleteTask(int id) async {
    final res = await http.delete(Uri.parse("$baseUrl$id/"));

    if (res.statusCode != 204) {
      throw Exception("Failed to delete task");
    }
  }
}