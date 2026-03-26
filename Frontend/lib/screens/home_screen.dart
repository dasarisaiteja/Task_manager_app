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
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: "Search..."),
            onChanged: provider.search,
          ),

          DropdownButton<String>(
            value: selectedStatus,
            items: ["all", "todo", "in_progress", "done"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) {
              setState(() => selectedStatus = val!);
            },
          ),

          Expanded(
            child: ListView(
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
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TaskForm()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}