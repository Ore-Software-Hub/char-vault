import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldComponent extends StatefulWidget {
  const TextFieldComponent(
      {super.key,
      required this.label,
      required this.onChanged,
      required this.value,
      this.maxlines = 1,
      this.keyboardType = TextInputType.text,
      this.enabled = true,
      this.hintText});

  final String label;
  final int? maxlines;
  final String value;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final bool? enabled;
  final String? hintText;

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
    _controller = TextEditingController(text: widget.value);
  }

  textFieldDecoration(String title) {
    return InputDecoration(
      labelText: title,
      hintText: widget.hintText,
      hintStyle: TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary, // Cor da borda
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Theme.of(context)
              .colorScheme
              .primary, // Cor da borda quando habilitado
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Theme.of(context)
              .colorScheme
              .primary, // Cor da borda quando focado
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.enabled,
      controller: _controller,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.keyboardType == TextInputType.number
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
      onChanged: (value) {
        widget.onChanged(value);
      },
      cursorColor: Theme.of(context).colorScheme.primary,
      decoration: textFieldDecoration(widget.label),
      maxLines: widget.maxlines,
      minLines: 1,
    );
  }
}
