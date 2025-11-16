import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/todo_provider.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xFFEAF9FF);
    final cardColor = const Color(0xFFF5FDFF);
    final provider = context.watch<TodoProvider>();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(title: const Text("Tarea App Examen Flutter")),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : provider.todos.isEmpty
              ? const Center(child: Text('No hay tareas'))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: ListView.separated(
                    itemCount: provider.todos.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final todo = provider.todos[i];
                      final textColor = todo.completed ? Colors.green.shade700 : Colors.red.shade700;

                      return Card(
                        color: cardColor,
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => context.push("/detail/${todo.id}"),
                          child: ListTile(
                            leading: Hero(
                              tag: 'todo-avatar-${todo.id}',
                              child: CircleAvatar(
                                backgroundColor: todo.completed ? Colors.green.shade400 : Colors.red.shade400,
                                child: Icon(
                                  todo.completed ? Icons.check : Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            title: Hero(
                              tag: 'todo-title-${todo.id}',
                              child: Material(
                                color: Colors.transparent,
                                child: Text(
                                  todo.todo,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: textColor,
                                    decoration: todo.completed ? TextDecoration.lineThrough : TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                            subtitle: Text(
                              'ID: ${todo.id} • Usuario: ${todo.userId}',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            trailing: PopupMenuButton(
                              itemBuilder: (context) => [
                               
                                PopupMenuItem(
                                  child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                                  onTap: () async {
                                    final confirm = await showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text("¿Eliminar tarea?"),
                                        content: const Text("Esta acción no se puede deshacer."),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(ctx, false),
                                            child: const Text("Cancelar"),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(ctx, true),
                                            child: const Text("Eliminar", style: TextStyle(color: Colors.red)),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (confirm == true) {
                                      if (context.mounted) {
                                       await provider.deleteTodo(todo.id);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text("Tarea eliminada")),
                                        );
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push("/create"),
        child: const Icon(Icons.add),
      ),
    );
  }
}
