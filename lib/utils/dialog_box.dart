import 'package:flutter/material.dart';
import 'package:todo_list/utils/my_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatefulWidget {
  TextEditingController controller;
  VoidCallback saveNewTask;
  DialogBox({super.key, required this.controller, required this.saveNewTask});
  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: SizedBox(
        height: 90,
        child: TextField(
          controller: widget.controller,
          decoration: const InputDecoration(
              hintText: "Create New Task", border: OutlineInputBorder()),
        ),
      ),
      actions: [
        MyButton(
            btnTitle: "Save",
            onPressed: () {
              widget.saveNewTask();
            }),
        MyButton(
            btnTitle: "Cancel",
            onPressed: () {
              widget.controller.clear();
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
