import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingBottomSheetComponent extends StatefulWidget {
  const LoadingBottomSheetComponent(
      {super.key,
      required this.title,
      required this.obj,
      required this.function});

  final String title;
  final dynamic obj;
  final Function function;

  @override
  _LoadingBottomSheetComponentState createState() =>
      _LoadingBottomSheetComponentState();
}

class _LoadingBottomSheetComponentState
    extends State<LoadingBottomSheetComponent> {
  double size = 250;
  @override
  void initState() {
    super.initState();
    widget.function();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 20),
        height: size,
        child: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            const Text(
              'Adicionado ao cofre...',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 50),
            LoadingAnimationWidget.discreteCircle(
                color: Theme.of(context).colorScheme.secondary, size: 50)
          ],
        ));
  }
}
