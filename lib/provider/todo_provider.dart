import 'package:flutter/foundation.dart';
import '../model/todo.dart';
import '../service/todo_api.dart';

class TodoProvider extends ChangeNotifier {
  final api = TodoApi();

  List<Todo> todos = [];
  bool loading = false;

  Future<void> fetchTodos() async {
    loading = true;
    notifyListeners();

    todos = await api.getTodos();

    loading = false;
    notifyListeners();
  }

  Future<void> addNewTodo(String title) async {
    final newTodo = await api.addTodo(title);
    todos.insert(0, newTodo);
    notifyListeners();
  }

  Future<void> updateTodoStatus(int id, bool completed) async {
    try {
      await api.updateTodo(id, completed);

      final index = todos.indexWhere((t) => t.id == id);
      if (index != -1) {
        todos[index].completed = completed;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      await api.deleteTodo(id);
      todos.removeWhere((t) => t.id == id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateTodo(int id, String title, bool completed) async {
  try {
    await api.updateTodoComplete(id, title, completed);

    final index = todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      todos[index] = Todo(
        id: todos[index].id,
        todo: title,
        completed: completed,
        userId: todos[index].userId,
      );
    }
    notifyListeners();
  } catch (e) {
    print(e);
  }
}
}
