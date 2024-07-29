import 'package:flutter/material.dart';

class TextFieldComponent extends StatefulWidget {
  const TextFieldComponent({super.key, required this.label, this.color, this.maxlines = 1});

  final String label;
  final Color? color;
  final int? maxlines;

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  textFieldDecoration(String title) {
    return InputDecoration(
      labelText: title,
      labelStyle: TextStyle(
          color: widget.color != null
              ? widget.color!
              : Theme.of(context)
                  .colorScheme
                  .primary), // Cor do rótulo do TextField
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: widget.color != null
              ? widget.color!
              : Theme.of(context).colorScheme.primary, // Cor da borda
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: widget.color != null
              ? widget.color!
              : Theme.of(context)
                  .colorScheme
                  .primary, // Cor da borda quando habilitado
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: widget.color != null
              ? widget.color!
              : Theme.of(context)
                  .colorScheme
                  .primary, // Cor da borda quando focado
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      style: TextStyle(
        color: widget.color != null
            ? widget.color!
            : Theme.of(context).colorScheme.primary,
      ),
      cursorColor: widget.color != null
          ? widget.color!
          : Theme.of(context).colorScheme.primary,
      decoration: textFieldDecoration(widget.label),
      maxLines: widget.maxlines,
    );
  }
}
