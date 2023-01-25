
  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/task_controller.dart';
import 'package:todo/model/todo_model.dart';

showAlertDialogForDelete(BuildContext context, String title, String message, Todo todo) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    context.read<TaskController>().deleteTodo(todo);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Yes")),
            ],
          );
        });
  }
