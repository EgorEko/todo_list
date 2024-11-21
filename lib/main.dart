import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/todo_unit.dart';
import 'repositories/storage_methods.dart';
import 'screens/home_screen.dart';
import 'services/todo_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'todo list app',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TodoProvider()),
        StreamProvider.value(
          value: StorageMethods().fetchTodos(),
          initialData: const <TodoUnit>[],
        ),
      ],
      child: MaterialApp(
        title: 'Todo list',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
