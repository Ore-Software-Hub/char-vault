// snackbar_helper.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NotificationHelper {
  static void showSnackBar(BuildContext context, String message,
      {int duration = 3, int level = 0}) {
    String title = "";
    PhosphorFlatIconData? icon;
    Color? bgColor, fgColor, iconColor;
    switch (level) {
      case 0:
        title = "Atenção";
        icon = PhosphorIconsBold.exclamationMark;
        bgColor = const Color(0xFF01499E);
        iconColor = const Color(0xFF009EFF);
        fgColor = Colors.white;
        break;
      case 1:
        title = "Sucesso";
        icon = PhosphorIconsBold.check;
        bgColor = const Color(0xFF019E5C);
        iconColor = const Color(0xFF00FF95);
        fgColor = Colors.white;
        break;
      case 2:
        title = "Ops! Ocorreu um erro";
        icon = PhosphorIconsBold.questionMark;
        bgColor = const Color(0xFF9E1401);
        iconColor = const Color(0xFFFF1E00);
        break;
    }
    final snackBar = SnackBar(
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: 100,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 46,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          color: fgColor,
                        ),
                      ),
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 14,
                          color: fgColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(20)),
              child: SvgPicture.asset("assets/img/bubbles.svg",
                  height: 48, width: 40, color: iconColor),
            ),
          ),
          Positioned(
            top: -10,
            left: 10,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(20)),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  SvgPicture.asset(
                    "assets/img/fail.svg",
                    height: 40,
                    color: iconColor,
                  ),
                  Positioned(
                    top: 5,
                    child: PhosphorIcon(icon!),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      duration: Duration(seconds: duration),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
