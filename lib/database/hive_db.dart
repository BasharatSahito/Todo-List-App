import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/utils/provider.dart';

class HiveDb {
  final BuildContext context; // Add this line to receive the context

  HiveDb(this.context); // Constructor to receive the context
  final _box = Hive.box("myBox");

  void getData() {
    final todoProvider = Provider.of<TodoListProvider>(context, listen: false);
    todoProvider.getDataProvider = _box.get("TODOLIST");
  }

  void saveNewTask(List<dynamic> newList) {
    final todoProvider = Provider.of<TodoListProvider>(context, listen: false);
    _box.put("TODOLIST", todoProvider.todoList);
  }
}
