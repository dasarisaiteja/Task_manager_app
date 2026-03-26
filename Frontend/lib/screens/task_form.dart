import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskForm extends StatefulWidget {
  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final title = TextEditingController();
  final desc = TextEditingController();
  String status = "todo";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Create Task")),
      body: Column(
        children: [
          TextField(controller: title, decoration: InputDecoration(labelText: "Title")),
          TextField(controller: desc, decoration: InputDecoration(labelText: "Description")),

          DropdownButton<String>(
            value: status,
            items: ["todo", "in_progress", "done"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => status = val!),
          ),

          ElevatedButton(
            onPressed: loading
                ? null
                : () async {
                    setState(() => loading = true);

                    await provider.addTask(
                      Task(
                        title: title.text,
                        description: desc.text,
                        dueDate: DateTime.now().toString(),
                        status: status,
                      ),
                    );

                    setState(() => loading = false);
                    Navigator.pop(context);
                  },
            child: loading
                ? CircularProgressIndicator()
                : Text("Save"),
          )
        ],
      ),
    );
  }
}