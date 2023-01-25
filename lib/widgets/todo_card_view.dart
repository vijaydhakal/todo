import 'package:flutter/material.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/pages/edit_task_details.dart';
import 'package:todo/utils/color_constants.dart';
import 'package:todo/utils/text_styles.dart';
import 'package:todo/utils/utils.dart';
import 'package:todo/widgets/delete_alert_dialog.dart';
import 'package:intl/intl.dart';

class TodoCardView extends StatelessWidget {
  const TodoCardView({Key? key, required this.todo, required this.showEdit}) : super(key: key);
  final bool showEdit;
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
                            context, Colors.deepOrange),
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
                if(showEdit)
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => EditTaskDetails(
                              todo: todo,
                            )));
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
