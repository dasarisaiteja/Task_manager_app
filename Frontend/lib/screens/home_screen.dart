import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../widgets/task_card.dart';
import 'task_form.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedStatus = "all";

  @override
  void initState() {
    super.initState();
      Future.microtask(() {
      Provider.of<TaskProvider>(context, listen: false).loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                border: OutlineInputBorder(),
              ),
              onChanged: provider.search,
            ),
          ),

          DropdownButton<String>(
            value: selectedStatus,
            items: [
              DropdownMenuItem(value: "all", child: Text("All")),
              DropdownMenuItem(value: "todo", child: Text("To-Do")),
              DropdownMenuItem(value: "in_progress", child: Text("In Progress")),
              DropdownMenuItem(value: "done", child: Text("Done")),
            ],
            onChanged: (val) {
              setState(() => selectedStatus = val!);
            },
          ),

          Expanded(
            child: provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    children: provider.filteredTasks
                        .where((task) =>
                            selectedStatus == "all" ||
                            task.status == selectedStatus)
                        .map((task) => TaskCard(task))
                        .toList(),
                  ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TaskForm()),
          );

          Provider.of<TaskProvider>(context, listen: false).loadTasks();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}