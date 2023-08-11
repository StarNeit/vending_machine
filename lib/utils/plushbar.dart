import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:vending_machine/core/enum/enums.dart';

class PpFlushBar {
  static void showErrorFlushBar(String? mess, BuildContext context) =>
      PpFlushBar.showFlushBar(
        context,
        type: FlushBarType.error,
        message: (mess ?? '').toString().trim(),
      );

  static void showSuccessFlushBar(String? mess, BuildContext context) =>
      PpFlushBar.showFlushBar(
        context,
        type: FlushBarType.success,
        message: (mess ?? '').toString().trim(),
      );

  static void showWarningFlushBar(String? mess, BuildContext context) =>
      PpFlushBar.showFlushBar(
        context,
        type: FlushBarType.warning,
        message: (mess ?? '').toString().trim(),
      );

  static Future<void> showFlushBar(
    BuildContext context, {
    FlushBarType type = FlushBarType.success,
    String title = "",
    String message = "",
    int duration = 3,
    FlushbarPosition position = FlushbarPosition.TOP,
  }) async {
    Color backgroundColor;
    Icon icon;
    //String _title;
    switch (type) {
      case FlushBarType.notification:
        backgroundColor = Colors.lightBlueAccent;
        icon = const Icon(Icons.info, color: Colors.white);
        // _title = "Warning";
        break;
      case FlushBarType.success:
        backgroundColor = Colors.green;
        icon = const Icon(Icons.check_circle, color: Colors.white);
        // _title = "Success";
        break;
      case FlushBarType.error:
        backgroundColor = const Color(0xFFf64438);
        icon = const Icon(Icons.error, color: Colors.white);
        // _title = "Error";
        break;
      case FlushBarType.warning:
        backgroundColor = const Color(0xFFedbc38);
        icon = const Icon(Icons.warning, color: Colors.white);
        // _title = "Alert";
        break;
    }

    // if (title != null && title.isNotEmpty) {
    //   _title = title;
    // }
    Flushbar flushBar;
    flushBar = Flushbar(
      messageSize: 14 / MediaQuery.of(context).textScaleFactor,
      isDismissible: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      message: message != ""
          ? message
          : title == ""
              ? "A system error has occurred!"
              : title,
      duration: Duration(seconds: duration),
      flushbarPosition: position,
      backgroundColor: backgroundColor,
      icon: icon,
      flushbarStyle: FlushbarStyle.GROUNDED,
    );
    await flushBar.show(context);
  }
}
