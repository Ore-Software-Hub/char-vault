import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:character_vault/constants/cores.constants.dart' as cores;

class ButtonComponent extends StatefulWidget {
  const ButtonComponent(
      {super.key,
      required this.pressed,
      this.tipo = 3,
      this.icon,
      this.label,
      this.color = cores.primaryColor});

  final VoidCallback pressed;
  final int tipo;

  final PhosphorFlatIconData? icon;
  final String? label;
  final Color? color;

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
        onPressed: widget.pressed,
        icon: PhosphorIcon(widget.icon!),
      );
    }
    if (widget.tipo == 1) {
      return ElevatedButton.icon(
        style: buttonStyle(),
        onPressed: widget.pressed,
        icon: PhosphorIcon(widget.icon!),
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
