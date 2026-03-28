import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskForm extends StatefulWidget {
  final Task? task;

  TaskForm({this.task});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final title = TextEditingController();
  final desc = TextEditingController();

  DateTime? selectedDate;
  String status = "todo";
  int? blockedBy;
  bool loading = false;

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      title.text = widget.task!.title;
      desc.text = widget.task!.description;
      selectedDate = DateTime.parse(widget.task!.dueDate);
      status = widget.task!.status;
      blockedBy = widget.task!.blockedBy;
    } else {
      loadDraft();
    }
  }

  Future<void> saveDraft() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("title", title.text);
    prefs.setString("desc", desc.text);
  }

  Future<void> loadDraft() async {
    final prefs = await SharedPreferences.getInstance();
    title.text = prefs.getString("title") ?? "";
    desc.text = prefs.getString("desc") ?? "";
  }

  Future<void> clearDraft() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("title");
    prefs.remove("desc");
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? "Create Task" : "Edit Task"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(labelText: "Title"),
              onChanged: (_) => saveDraft(),
            ),

            TextField(
              controller: desc,
              decoration: InputDecoration(labelText: "Description"),
              onChanged: (_) => saveDraft(),
            ),

            SizedBox(height: 10),

            // 📅 Date Picker
            Row(
              children: [
                Text(selectedDate == null
                    ? "Select Due Date"
                    : selectedDate.toString().split(" ")[0]),
                Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() => selectedDate = picked);
                    }
                  },
                  child: Text("Pick"),
                )
              ],
            ),

            SizedBox(height: 10),

            // 🔽 Status
            DropdownButton<String>(
              value: status,
              isExpanded: true,
              items: [
                DropdownMenuItem(value: "todo", child: Text("To-Do")),
                DropdownMenuItem(
                    value: "in_progress", child: Text("In Progress")),
                DropdownMenuItem(value: "done", child: Text("Done")),
              ],
              onChanged: (val) => setState(() => status = val!),
            ),

            SizedBox(height: 10),

            // 🔗 Blocked By
            DropdownButton<int?>(
              value: blockedBy,
              hint: Text("Blocked By"),
              isExpanded: true,
              items: [
                DropdownMenuItem(value: null, child: Text("None")),
                ...provider.tasks.map((task) => DropdownMenuItem(
                      value: task.id,
                      child: Text(task.title),
                    ))
              ],
              onChanged: (val) => setState(() => blockedBy = val),
            ),

            SizedBox(height: 20),

            // 💾 Save Button
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () async {
                      if (selectedDate == null) return;

                      setState(() => loading = true);

                      final newTask = Task(
                        id: widget.task?.id,
                        title: title.text,
                        description: desc.text,
                        dueDate: selectedDate.toString().split(" ")[0],
                        status: status,
                        blockedBy: blockedBy,
                      );

                      try {
                        if (widget.task == null) {
                          await provider.addTask(newTask);
                        } else {
                          await provider.updateTask(newTask);
                        }

                        await clearDraft();
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error saving task")),
                        );
                      } finally {
                        setState(() => loading = false);
                      }
                    },
              child: loading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}