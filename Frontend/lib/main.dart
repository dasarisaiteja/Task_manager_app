import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/task_provider.dart';
import 'screens/home_screen.dart';
import 'screens/task_form.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      debugShowCheckedModeBanner: false,

      // ✅ ROUTES FIXED
      routes: {
        '/task-form': (context) {
          final task =
              ModalRoute.of(context)!.settings.arguments as dynamic;
          return TaskForm(task: task);
        },
      },

      // ✅ HOME
      home: HomeScreen(),
    );
  }
}