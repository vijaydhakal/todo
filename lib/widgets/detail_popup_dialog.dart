import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/task_controller.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/pages/edit_task_details.dart';
import 'package:todo/utils/color_constants.dart';
import 'package:todo/utils/text_styles.dart';
import 'package:todo/utils/utils.dart';
import 'package:intl/intl.dart';

void popUpViewDialog({required BuildContext context, required Todo todo, required bool showEdit}) {
  var dateFormat = DateFormat('dd-MMM-yyyy');
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.close),
                            )),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Task",
                              style: AppTextStyle.textHeaderBoldwithColor(
                                  context, primaryColor),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            todo.title.toString().capitalize(),
                            style: AppTextStyle.textHeader(context),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            todo.description.toString(),
                            style: AppTextStyle.bodyBoldText(context),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dateFormat.format(todo.taskDate).toString(),
                                style: AppTextStyle.bodytext(context),
                              ),
                              Text(
                                (todo.isDone == true) ? "Completed" : "Pending",
                                style: AppTextStyle.textHeaderwithColor(
                                    context, Colors.deepOrange),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  showAlertDialogForMarkDone(
                                      context,
                                      "Confirm Dialog",
                                      "Are you sure the task is completed. You want to proceed?",
                                      todo);
                                },
                                child: Text(
                                  "Mark Completed",
                                  style: AppTextStyle.buttonTextlableStyle(
                                      context),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditTaskDetails(
                                            todo: todo,
                                          )));
                                },
                                child: Text(
                                  "Edit",
                                  style: AppTextStyle.buttonTextlableStyle(
                                      context),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        );
      });
}

showAlertDialogForMarkDone(
    BuildContext context, String title, String message, Todo todo) {
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
                  context.read<TaskController>().updateTodoCompleted(todo);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text("Yes")),
          ],
        );
      });
}
