import 'package:flutter/material.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/utils/text_styles.dart';
import 'package:todo/utils/utils.dart';

class ActiveTaskList extends StatelessWidget {

  const ActiveTaskList({Key? key, required this.todoData}) : super(key: key);
  final Todo todoData;

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.pending_actions,
                size: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SizedBox(
                  width: deviceSize.width * 72 / 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(todoData.title.toString().capitalize(),
                          style: AppTextStyle.textHeader(context)),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(todoData.description.toString().capitalize(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.bodytext(context)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 1.5,
          )
        ],
      ),
    );
  }
}
