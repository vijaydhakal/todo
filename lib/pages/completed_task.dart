import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/task_controller.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/service/auth.dart';
import 'package:todo/utils/color_constants.dart';
import 'package:todo/utils/text_styles.dart';
import 'package:todo/utils/utils.dart';
import 'package:todo/widgets/delete_alert_dialog.dart';
import 'package:todo/widgets/no_data_found.dart';

class CompletedTask extends StatefulWidget {
  const CompletedTask({Key? key}) : super(key: key);

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthMethods>().user;
    context.watch<TaskController>().readAllTodo(user.uid);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
              iconSize: 30,
              icon: Icon(Icons.arrow_back, color: accentColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: primaryColor,
            centerTitle: true,
            title: const Text("Completed task")),
        body: Container(
          color: primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Consumer<TaskController>(
                    builder: (context, taskData, child) {
                      if (taskData.loadScreen) {
                        return buildLoader();
                      } else if (taskData.todosCompleted.isEmpty) {
                        return const NoDataFound(
                            title: "No any completed task");
                      } else if (taskData.todosCompleted.isNotEmpty) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: taskData.todosCompleted.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    popUpViewDialog(context,
                                        taskData.todosCompleted[index]);
                                  },
                                  child: TodoCardView(
                                    todo: taskData.todosCompleted[index],
                                  ));
                            });
                      } else {
                        return Center(
                            child: Text(
                          'Something went wrong... Please try again later',
                          style: AppTextStyle.bodyErrorText(context),
                        ));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void popUpViewDialog(BuildContext context, todo) {
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Todo Task",
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
                        todo.description.toString().capitalize(),
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
                                context, Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Close",
                                style:
                                    AppTextStyle.buttonTextlableStyle(context),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class TodoCardView extends StatelessWidget {
  const TodoCardView({Key? key, required this.todo}) : super(key: key);

  final Todo todo;
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var dateFormat = DateFormat('dd-MMM-yyyy');
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: deviceSize.width * 65 / 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dateFormat.format(todo.taskDate).toString(),
                        style: AppTextStyle.textHeaderwithColor(
                            context, primaryColor),
                      ),
                      Text(
                        (todo.isDone == true) ? "Completed" : "Pending",
                        style: AppTextStyle.textHeaderwithColor(
                            context, Colors.green),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    todo.title.toString().capitalize(),
                    style: AppTextStyle.textHeader(context),
                  ),
                  Text(
                    todo.description.toString().capitalize(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.bodyBoldText(context),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    showAlertDialogForDelete(context, "Conform Dialog",
                        "Are you sure you want to delete this task", todo);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
