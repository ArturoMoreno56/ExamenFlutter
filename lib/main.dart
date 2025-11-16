import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';
import 'provider/todo_provider.dart';
import 'theme/app_theme.dart'; 

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoProvider()..fetchTodos(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TaskMaster AP',
      theme: AppTheme.lightTheme, 
      routerConfig: appRouter,
    );
  }
}
