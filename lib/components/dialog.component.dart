import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DialogComponent extends StatefulWidget {
  const DialogComponent({super.key, required this.message});
  final String message;
  @override
  _DialogComponentState createState() => _DialogComponentState();
}

class _DialogComponentState extends State<DialogComponent>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Lottie.asset(
              'assets/lottie/questionMark.json',
              controller: _controller,
              onLoaded: (composition) {
                // Configure the AnimationController with the duration of the
                // Lottie file and start the animation.
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
            ),
          ),
          Text(
            "Confirmação",
            style: AppTextStyles.boldText(context),
          )
        ],
      ),
      content: Text(widget.message),
      actions: <Widget>[
        ButtonComponent(
          pressed: () {
            Navigator.of(context).pop(false); // Dismiss the dialog
          },
          label: "Não",
        ),
        ButtonComponent(
          pressed: () {
            Navigator.of(context).pop(true); // Dismiss the dialog
          },
          label: "Sim",
        ),
      ],
    );
  }
}
