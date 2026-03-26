import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  TaskCard(this.task);

  @override
  Widget build(BuildContext context) {
    bool isBlocked = task.blockedBy != null && task.status != "done";

    return Card(
      color: isBlocked ? Colors.grey[300] : Colors.white,
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            Provider.of<TaskProvider>(context, listen: false)
                .deleteTask(task.id!);
          },
        ),
      ),
    );
  }
}