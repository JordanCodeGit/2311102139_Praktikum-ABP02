import 'package:flutter/foundation.dart';
import '../models/todo_model.dart';

class TodoProvider with ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => List.unmodifiable(_todos);

  void addTodo(String title) {
    if (title.trim().isEmpty) return;
    _todos.add(Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
    ));
    notifyListeners();
  }

  void toggleTodo(String id) {
    final todo = _todos.firstWhere((t) => t.id == id);
    todo.completed = !todo.completed;
    notifyListeners();
  }

  void clearAll() {
    _todos.clear();
    notifyListeners();
  }
}