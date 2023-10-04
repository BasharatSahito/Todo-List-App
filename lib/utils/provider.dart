import 'package:flutter/material.dart';

class TodoListProvider with ChangeNotifier {
  List<dynamic> _todoList = [];

  List<dynamic> get todoList => _todoList;

  set getDataProvider(List<dynamic> newList) {
    _todoList = newList;
    // notifyListeners();
  }

  void checkBoxProvider(int index) {
    _todoList[index][1] = !_todoList[index][1];
    notifyListeners();
  }

  void makeNewTask(TextEditingController controller) {
    _todoList.add([controller.text.toString(), false]);
    notifyListeners();
  }

  void removeTask(int index) {
    _todoList.removeAt(index);
    notifyListeners();
  }
}
