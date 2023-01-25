import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/pages/add_new_task.dart';
import 'package:todo/pages/all_todo_task.dart';
import 'package:todo/pages/completed_task.dart';
import 'package:todo/service/auth.dart';
import 'package:todo/utils/assets.dart';
import 'package:todo/utils/text_styles.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(AppAssets.leaf))),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: AppTextStyle.sideMenuHeaderStyle(context),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      user.displayName.toString(),
                      style: AppTextStyle.sideMenuHeaderStyle(context),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      user.email.toString(),
                      style: AppTextStyle.sideMenuHeaderStyle(context),
                    ),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              color: Colors.black54,
            ),
            title: Text(
              'Home',
              style: AppTextStyle.sideMenuTextStyle(context),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(
              Icons.add_task_outlined,
              color: Colors.black54,
            ),
            title: Text(
              'Add New Tasks',
              style: AppTextStyle.sideMenuTextStyle(context),
            ),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddNewTask()))
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.task_outlined,
              color: Colors.black54,
            ),
            title: Text(
              'All Tasks',
              style: AppTextStyle.sideMenuTextStyle(context),
            ),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AllTodoTask()))
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.task_alt,
              color: Colors.black54,
            ),
            title: Text(
              'Completed Task',
              style: AppTextStyle.sideMenuTextStyle(context),
            ),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CompletedTask()))
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.black54,
            ),
            title: Text(
              'Logout',
              style: AppTextStyle.sideMenuTextStyle(context),
            ),
            onTap: () => {
              context.read<AuthMethods>().signOut(context),
            },
          ),
        ],
      ),
    );
  }
}
