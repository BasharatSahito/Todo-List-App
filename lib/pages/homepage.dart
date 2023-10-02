import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/database/hive_db.dart';
import 'package:todo_list/utils/dialog_box.dart';
import 'package:todo_list/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _box = Hive.box("myBox");
  HiveDb db = HiveDb();
  @override
  void initState() {
    super.initState();
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
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.saveNewTask(db.todoList);
  }

  TextEditingController controller = TextEditingController();

  void saveNewTask() {
    if (controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Please Write a Todo Task Name",
          style: TextStyle(color: Colors.white),
        ),
      ));
    } else {
      setState(() {
        db.todoList.add([controller.text.toString(), false]);
        controller.clear();
      });
      db.saveNewTask(db.todoList);
      Navigator.of(context).pop();
    }
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: controller,
          saveNewTask: saveNewTask,
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.saveNewTask(db.todoList);
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
      body: initialData() == false
          ? const Center(
              child: Text(
                "Create New Task",
                style: TextStyle(fontSize: 17),
              ),
            )
          : ListView.builder(
              itemCount: db.todoList.length,
              itemBuilder: (context, index) {
                return TodoTile(
                  tileTitle: db.todoList[index][0],
                  taskCompleted: db.todoList[index][1],
                  onChanged: (value) => checkBoxChanged(index),
                  deleteTask: (value) => deleteTask(index),
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
