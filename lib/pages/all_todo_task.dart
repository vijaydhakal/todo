import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/task_controller.dart';
import 'package:todo/service/auth.dart';
import 'package:todo/utils/color_constants.dart';
import 'package:todo/utils/text_styles.dart';
import 'package:todo/utils/utils.dart';
import 'package:todo/widgets/detail_popup_dialog.dart';
import 'package:todo/widgets/no_data_found.dart';
import 'package:todo/widgets/todo_card_view.dart';

class AllTodoTask extends StatefulWidget {
  const AllTodoTask({Key? key}) : super(key: key);

  @override
  State<AllTodoTask> createState() => AllTodoTaskState();
}

class AllTodoTaskState extends State<AllTodoTask> {
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
            title: const Text("All todo task")),
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
                      } else if (taskData.todos.isEmpty) {
                        return const NoDataFound(
                          title:
                              'There are no data for todo task.\n Add new tasks to view.',
                        );
                      } else if (taskData.todos.isNotEmpty) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: taskData.todos.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    popUpViewDialog(
                                        context:context, todo:taskData.todos[index],
                                        showEdit: true);
                                  },
                                  child: TodoCardView(
                                    todo: taskData.todos[index],
                                    showEdit: true,
                                  ));
                            });
                      } else {
                        return Center(
                            child: Text(
                          'Something went wrong. Please try again later',
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
}
