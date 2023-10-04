import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/database/hive_db.dart';
import 'package:todo_list/utils/dialog_box.dart';
import 'package:todo_list/utils/provider.dart';
import 'package:todo_list/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _box = Hive.box("myBox");

  late HiveDb db;

  @override
  void initState() {
    super.initState();
    db = HiveDb(context);
    initialData();
  }

  bool initialData() {
    bool value;
    List<dynamic>? todoList = _box.get("TODOLIST");
    if (todoList == null || todoList.isEmpty) {
      value = false;
    } else {
      value = true;
      db.getData();
    }
    return value;
  }

  void checkBoxChanged(int index) {
    final todoProvider = Provider.of<TodoListProvider>(context, listen: false);
    todoProvider.checkBoxProvider(index);
    db.saveNewTask(todoProvider.todoList);
  }

  TextEditingController controller = TextEditingController();

  void createNewTask() {
    if (controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Please Write a Todo Task Name",
          style: TextStyle(color: Colors.white),
        ),
      ));
    } else {
      final todoProvider =
          Provider.of<TodoListProvider>(context, listen: false);
      todoProvider.makeNewTask(controller);
      controller.clear();
      db.saveNewTask(todoProvider.todoList);
      Navigator.of(context).pop();
    }
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: controller,
          saveNewTask: createNewTask,
        );
      },
    );
  }

  void deleteTask(int index) {
    final todoProvider = Provider.of<TodoListProvider>(context, listen: false);
    todoProvider.removeTask(index);
    db.saveNewTask(todoProvider.todoList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TO DO"),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.yellow[200],
      body: Consumer<TodoListProvider>(
        builder: (context, value, child) {
          bool hasData = initialData();
          return hasData == false
              ? const Center(
                  child: Text(
                    "Create New Task",
                    style: TextStyle(fontSize: 17),
                  ),
                )
              : ListView.builder(
                  itemCount: value.todoList.length,
                  itemBuilder: (context, index) {
                    return TodoTile(
                      tileTitle: value.todoList[index][0],
                      taskCompleted: value.todoList[index][1],
                      onChanged: (value) => checkBoxChanged(index),
                      deleteTask: (value) => deleteTask(index),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createTask(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
