import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navKey = GlobalKey();
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
