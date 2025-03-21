// snackbar_helper.dart
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NotificationHelper {
  static void showSnackBar(BuildContext context, String message,
      {int duration = 3, String level = 'info'}) {
    late PhosphorFlatIconData icon;
    Color? bgColor, fgColor;

    switch (level) {
      case 'info':
        icon = PhosphorIconsFill.info;
        bgColor = Colors.blue.shade100;
        fgColor = Colors.blue;
        break;
      case 'success':
        icon = PhosphorIconsFill.checkCircle;
        bgColor = Colors.green.shade100;
        fgColor = Colors.green.shade700;
        break;
      case 'warning':
        icon = PhosphorIconsFill.warning;
        bgColor = Colors.yellow.shade100;
        fgColor = Colors.black;
        break;
      case 'error':
        icon = PhosphorIconsFill.xCircle;
        bgColor = Colors.red.shade100;
        fgColor = Colors.red;
        break;
    }

    final snackBar = SnackBar(
      content: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: bgColor),
        child: Row(
          spacing: 5,
          children: [
            PhosphorIcon(
              icon,
              color: fgColor,
            ),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: fgColor),
                maxLines: 3,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
      duration: Duration(seconds: duration),
      backgroundColor: Colors.transparent,
      elevation: 0,
      dismissDirection: DismissDirection.horizontal,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
