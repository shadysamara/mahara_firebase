import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navKey = GlobalKey();
  static showLoaderDialog() {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: navKey.currentContext!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static hideLoadingDialoug() {
    navKey.currentState!.pop();
  }

  static showCustomDiaoug(String content) {
    showDialog(
        context: navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    navKey.currentState!.pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  static navigateToScreen(Widget widget) {
    navKey.currentState!.push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  static navigateAndReplaceScreen(Widget widget) {
    navKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}
