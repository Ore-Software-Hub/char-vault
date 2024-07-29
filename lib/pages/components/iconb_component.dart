import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:character_vault/constants/cores.constants.dart' as cores;

class IconButtonComponent extends StatefulWidget {
  const IconButtonComponent({
    super.key,
    required this.pressed,
    required this.icon,
  });

  final VoidCallback pressed;
  final PhosphorFlatIconData icon;

  @override
  State<IconButtonComponent> createState() => _IconButtonComponentState();
}

class _IconButtonComponentState extends State<IconButtonComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(8)), // Torna o botão quadrado
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
          backgroundColor: const WidgetStatePropertyAll(cores.primaryColor)),
      onPressed: widget.pressed,
      icon: PhosphorIcon(widget.icon),
    );
  }
}
