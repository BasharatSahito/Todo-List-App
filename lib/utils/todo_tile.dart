import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class TodoTile extends StatefulWidget {
  String tileTitle;
  bool taskCompleted;
  void Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;

  TodoTile({
    super.key,
    required this.tileTitle,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteTask,
  });
  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (value) {
                widget.deleteTask!(value);
              },
              icon: Icons.delete,
              backgroundColor: Colors.red,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.yellow, borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Checkbox(
                  activeColor: Colors.black,
                  value: widget.taskCompleted,
                  onChanged: widget.onChanged,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.tileTitle,
                  style: TextStyle(
                      fontSize: 16,
                      decoration: widget.taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
