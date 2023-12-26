import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/help_page.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer(
      {super.key, required this.userModel, required this.firebaseUser});
  final UserModel userModel;
  final User firebaseUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      UserAccountsDrawerHeader(
        accountName: Text(
          userModel.fullname.toString(),
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        accountEmail: Text(
          userModel.email.toString(),
          style: TextStyle(fontSize: 15),
        ),
        currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage(userModel.profilePic.toString()),
        ),
      ),
      ListTile(
        leading: Icon(Icons.inbox),
        title: Text("Inbox"),
        onTap: () {
          Navigator.pop(context);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return HomePage(
          //         firebaseUser: firebaseUser,
          //         userModel: userModel,
          //       );
          //     },
          //   ),
          // );
        },
      ),
      ListTile(
        leading: Icon(Icons.label_important),
        title: Text("Important"),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.report),
        title: Text("Spam"),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.delete),
        title: Text("Trash"),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.markunread),
        title: Text("Unread"),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text("Settings"),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.help),
        title: Text("Help"),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HelpPage();
              },
            ),
          );
        },
      ),
    ]));
  }
}
