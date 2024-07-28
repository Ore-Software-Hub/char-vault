import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:character_vault/constants/cores.constants.dart' as cores;

class ButtonRollComponent extends StatefulWidget {
  const ButtonRollComponent({
    super.key,
    required this.pressed,
    required this.icon,
    required this.label,
  });

  final VoidCallback pressed;
  final String label;
  final PhosphorFlatIconData icon;

  @override
  State<ButtonRollComponent> createState() => _ButtonRollComponentState();
}

class _ButtonRollComponentState extends State<ButtonRollComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return cores.secondaryColor; // Altere para a cor desejada
                }
                return null; // Use o valor padrão para outros estados
              },
            ),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
            backgroundColor: const WidgetStatePropertyAll(cores.primaryColor),
            padding: const WidgetStatePropertyAll(
                EdgeInsets.only(left: 12, right: 12))),
        onPressed: widget.pressed,
        icon: PhosphorIcon(
          widget.icon,
        ),
        label: Text(widget.label));
  }
}
