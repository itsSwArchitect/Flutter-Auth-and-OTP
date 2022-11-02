import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class Constants {
  static navigateToScreen(BuildContext context, screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static replaceToScreen(BuildContext context, screen) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));
  }
}

const kHeadertextStyles =
    TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.amber);

const kButtonTextStyles =
    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
double baseSize = 640.0;
double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseSize;
}

double screenAwareHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double screenAwareWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

class Utils {
  static void showErrorFlush(
      BuildContext context, String? title, String? message) async {
    await Flushbar(
      title: title,
      titleColor: Colors.red,
      message: message,
      messageColor: Colors.white,
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
