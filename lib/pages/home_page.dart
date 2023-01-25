import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/task_controller.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/pages/active_task_list.dart';
import 'package:todo/pages/add_new_task.dart';
import 'package:todo/pages/nav_drawer.dart';
import 'package:todo/service/auth.dart';
import 'package:todo/utils/assets.dart';
import 'package:todo/utils/color_constants.dart';
import 'package:todo/utils/text_styles.dart';
import 'package:intl/intl.dart';
import 'package:todo/utils/utils.dart';
import 'package:todo/widgets/detail_popup_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat('yyyy-MM-dd');
    var todaysDate = dateFormat.format(DateTime.now());
    var deviceSize = MediaQuery.of(context).size;
    final user = context.read<AuthMethods>().user;
    Provider.of<TaskController>(context, listen: true)
        .readTodoByDate(user.uid, todaysDate);

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: NavDrawer(user: user),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Column(
              children: [
                Stack(
                  children: <Widget>[
                    SizedBox(
                        height: deviceSize.height / 3.5,
                        width: deviceSize.width,
                        child: Image.asset(
                          AppAssets.background2,
                          fit: BoxFit.fill,
                        )),
                    Positioned(
                      top: 50,
                      left: 20,
                      right: 20,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome",
                                  style:
                                      AppTextStyle.sideMenuHeaderStyle(context),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  user.displayName ?? "Your's task",
                                  style:
                                      AppTextStyle.sideMenuHeaderStyle(context),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  DateFormat('dd-MMM-yyy')
                                      .format(DateTime.now())
                                      .toString(),
                                  style: AppTextStyle.formtextStyle(context),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 30, top: 40),
                              child: Column(
                                children: [
                                  Text(
                                    context
                                        .read<TaskController>()
                                        .todaysTodo
                                        .length
                                        .toString(),
                                    style:
                                        AppTextStyle.numberTextStyle(context),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "pending",
                                    style: AppTextStyle.sideMenuHeaderStyle(
                                        context),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: Container(
                  color: Colors.white70,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          child: Text(
                            "Today's Tasks",
                            style: AppTextStyle.appBarTextStyle(context),
                          ),
                        ),
                        SizedBox(
                          height: deviceSize.height / 1.9,
                          child: Consumer<TaskController>(
                              builder: (context, todoData, _) {
                            if (todoData.loadScreen) {
                              return buildLoader();
                            } else if (todoData.todaysTodo.isEmpty) {
                              return Center(
                                  child: Text(
                                "There are no task added.",
                                style: AppTextStyle.textHeader(context),
                              ));
                            } else if (todoData.todaysTodo.isNotEmpty) {
                              return ListView.builder(
                                itemCount: todoData.todaysTodo.length,
                                itemBuilder: ((context, index) {
                                  return GestureDetector(
                                    child: ActiveTaskList(
                                        todoData: todoData.todaysTodo[index]),
                                    onTap: () {
                                      popUpViewDialog(
                                          context: context,todo: todoData.todaysTodo[index],
                                          showEdit: true);
                                    },
                                  );
                                }),
                              );
                            } else {
                              return Center(
                                  child: Text(
                                'Something went wrong. Try again later',
                                style: AppTextStyle.bodytext(context),
                              ));
                            }
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 20,
                              child: Text(
                                "Completed".toUpperCase(),
                                style: AppTextStyle.appBarTextStyle(context),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Center(
                              child: Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: const BoxDecoration(
                                    color: Colors.blueGrey,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    context
                                        .read<TaskController>()
                                        .todaysCompleted
                                        .length
                                        .toString(),
                                    style: AppTextStyle.bodyBoldText1(context),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
            Positioned(
              left: 10.0,
              top: 10.0,
              child: InkWell(
                child: const Icon(
                  Icons.menu_rounded,
                  size: 30.0,
                  color: Colors.white,
                ),
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, right: 10.0),
          child: FloatingActionButton(
            elevation: 6.0,
            tooltip: "Add New Task",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddNewTask()));
            },
            backgroundColor: accentColor,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
