import 'package:flutter/material.dart';

class UIHelper {
  static void showLoadingDialog(BuildContext context, String title) {
    AlertDialog loadingDialog = AlertDialog(
      backgroundColor: Color.fromARGB(255, 74, 31, 79),
      content: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Color.fromARGB(255, 250, 186, 249),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              title,
              style: TextStyle(
                color: Color.fromARGB(255, 250, 186, 249),
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return loadingDialog;
        });
  }

  static void showAlertDialog(
      BuildContext context, String title, String content) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title,
          style: TextStyle(
            color: Color.fromARGB(255, 250, 186, 249),
            fontSize: 20,
          )),
      content: Text(content,
          style: TextStyle(
            color: Color.fromARGB(255, 250, 186, 249),
            fontSize: 18,
          )),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok",
              style: TextStyle(
                color: Color.fromARGB(255, 250, 186, 249),
                fontSize: 18,
              )),
        ),
      ],
      backgroundColor: Color.fromARGB(255, 74, 31, 79),
    );

    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
}
