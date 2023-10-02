import 'package:hive/hive.dart';

class HiveDb {
  final _box = Hive.box("myBox");
  List todoList = [];

  void getData() {
    todoList = _box.get("TODOLIST");
  }

  void saveNewTask(List<dynamic> newList) {
    _box.put("TODOLIST", todoList);
  }
}
