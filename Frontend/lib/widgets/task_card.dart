import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  TaskCard(this.task);

  Widget highlightText(String text, String query) {
    if (query.isEmpty) return Text(text);

    final lower = text.toLowerCase();
    final q = query.toLowerCase();

    final start = lower.indexOf(q);

    if (start == -1) return Text(text);

    final end = start + q.length;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: text.substring(0, start),
              style: TextStyle(color: Colors.black)),
          TextSpan(
              text: text.substring(start, end),
              style: TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold)),
          TextSpan(
              text: text.substring(end),
              style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    bool isBlocked = false;

    if (task.blockedBy != null) {
      try {
        final blockingTask =
            provider.tasks.firstWhere((t) => t.id == task.blockedBy);

        if (blockingTask.status != "done") {
          isBlocked = true;
        }
      } catch (_) {}
    }

    return Card(
      color: isBlocked ? Colors.grey[300] : Colors.white,
      child: ListTile(
        title: highlightText(task.title, provider.searchQuery),
        subtitle: Text("${task.description}\nDue: ${task.dueDate}"),
        isThreeLine: true,

        onTap: () {
          Navigator.pushNamed(context, '/task-form', arguments: task);
        },

        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            provider.deleteTask(task.id!);
          },
        ),
      ),
    );
  }
}