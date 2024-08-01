import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:CharVault/constants/cores.constants.dart' as cores;

class ButtonComponent extends StatefulWidget {
  const ButtonComponent(
      {super.key,
      required this.pressed,
      this.tipo = 3,
      this.icon,
      this.label,
      this.loading = false,
      this.color = cores.primaryColor});

  final Function()? pressed;
  final int tipo;

  final PhosphorFlatIconData? icon;
  final String? label;
  final Color? color;
  final bool loading;

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  @override
  void initState() {
    super.initState();
  }

  buttonStyle() {
    return ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(8)), // Torna o botão quadrado
          ),
        ),
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return cores.secondaryColor; // Altere para a cor desejada
            }
            return null; // Use o valor padrão para outros estados
          },
        ),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        backgroundColor: WidgetStatePropertyAll(widget.color!));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tipo == 0) {
      return IconButton(
        style: buttonStyle(),
        onPressed: widget.pressed!,
        icon: PhosphorIcon(widget.icon!),
      );
    }
    if (widget.tipo == 1) {
      return ElevatedButton.icon(
        style: buttonStyle(),
        onPressed: widget.pressed,
        icon: widget.loading
            ? LoadingAnimationWidget.twistingDots(
                leftDotColor: Theme.of(context).colorScheme.primary,
                rightDotColor: Theme.of(context).colorScheme.onPrimary,
                size: 20)
            : PhosphorIcon(widget.icon!),
        label: Text(widget.label!),
      );
    }
    return ElevatedButton(
      style: buttonStyle(),
      onPressed: widget.pressed,
      child: Text(widget.label!),
    );
  }
}
