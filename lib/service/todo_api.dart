import 'package:dio/dio.dart';
import '../model/todo.dart';

class TodoApi {
  final dio = Dio(BaseOptions(baseUrl: "https://dummyjson.com"));

  Future<List<Todo>> getTodos() async {
    final res = await dio.get("/todos");
    final list = res.data["todos"] as List;
    return list.map((e) => Todo.fromJson(e)).toList();
  }

  Future<Todo> getTodoById(int id) async {
    final res = await dio.get("/todos/$id");
    return Todo.fromJson(res.data);
  }

  Future<Todo> addTodo(String title) async {
    final res = await dio.post("/todos/add", data: {
      "todo": title,
      "completed": false,
      "userId": 1
    });
    return Todo.fromJson(res.data);
  }

  Future<void> updateTodo(int id, bool completed) async {
    await dio.put("/todos/$id", data: {
      "completed": completed,
    });
  }

  Future<void> updateTodoComplete(int id, String title, bool completed) async {
    await dio.put("/todos/$id", data: {
      "todo": title,
      "completed": completed,
    });
  }

  Future<void> deleteTodo(int id) async {
    await dio.delete("/todos/$id");
  }
}
