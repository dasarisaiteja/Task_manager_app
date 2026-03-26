import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class ApiService {
  final String baseUrl = "http://127.0.0.1:8000/api/tasks/";

  Future<List<Task>> fetchTasks() async {
    final res = await http.get(Uri.parse(baseUrl));
    final data = jsonDecode(res.body);
    return data.map<Task>((e) => Task.fromJson(e)).toList();
  }

  Future<void> createTask(Task task) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(task.toJson()),
    );
  }

  Future<void> updateTask(Task task) async {
    await http.put(
      Uri.parse("$baseUrl${task.id}/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(task.toJson()),
    );
  }

  Future<void> deleteTask(int id) async {
    await http.delete(Uri.parse("$baseUrl$id/"));
  }
}