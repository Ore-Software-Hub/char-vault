import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ButtonComponent extends StatefulWidget {
  /// Tipo: '0: Normal', '1: Normal com icone', '2: textButton', '3: iconButton'
  const ButtonComponent(
      {super.key,
      required this.pressed,
      this.tipo = 0,
      this.icon,
      this.label,
      this.loading = false,
      this.disabled = false,
      this.selected = false});

  final Function()? pressed;
  final int tipo;
  final PhosphorFlatIconData? icon;
  final String? label;
  final bool loading;
  final bool disabled;
  final bool selected;

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  @override
  void initState() {
    super.initState();
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return Theme.of(context).colorScheme.secondary;
          }
          return null;
        },
      ),
      foregroundColor: WidgetStateProperty.all<Color>(
        widget.disabled ? Colors.grey : Colors.white,
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey.shade400; // Cor do botão desativado
          }
          return Theme.of(context).colorScheme.primary;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.disabled || widget.pressed == null;

    if (widget.tipo == 0) {
      return ElevatedButton(
        style: buttonStyle(),
        onPressed: isDisabled ? null : widget.pressed,
        child: Text(
          widget.label!,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      );
    }

    if (widget.tipo == 1) {
      return ElevatedButton.icon(
        style: buttonStyle(),
        onPressed: isDisabled ? null : widget.pressed,
        icon: widget.loading
            ? LoadingAnimationWidget.twistingDots(
                leftDotColor: Theme.of(context).colorScheme.primary,
                rightDotColor: Theme.of(context).colorScheme.onPrimary,
                size: 20)
            : PhosphorIcon(widget.icon!),
        label: Text(widget.label!),
      );
    }

    if (widget.tipo == 2) {
      return TextButton(
        onPressed: isDisabled ? null : widget.pressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(
                  color: widget.selected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        child: Text(
          widget.label!,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      );
    }
    if (widget.tipo == 3) {
      return IconButton(
        style: buttonStyle(),
        onPressed: isDisabled ? null : widget.pressed,
        icon: PhosphorIcon(widget.icon!),
      );
    }
    return Container();
  }
}
