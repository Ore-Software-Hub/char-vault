import 'package:flutter/material.dart';
import 'package:CharVault/constants/cores.constants.dart' as cores;

class DropdownComponent extends StatefulWidget {
  const DropdownComponent({
    super.key,
    required this.onChanged,
    this.items = const ["Armadura", "Ferramenta", "Arma", "Magia"],
    this.hintText,
    this.backgroundColor = Colors.white,
    this.foregroundColor = cores.primaryColor,
  });

  final Function(String?)? onChanged;
  final String? hintText;
  final List<String> items;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  State<DropdownComponent> createState() => _DropdownComponentState();
}

class _DropdownComponentState extends State<DropdownComponent> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      hint: Text(
        widget.hintText!,
        style: TextStyle(color: widget.foregroundColor!),
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue;
        });
        widget.onChanged!(newValue); // Chama a função de callback
      },
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.backgroundColor!,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.foregroundColor!, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: widget.foregroundColor!, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.foregroundColor!, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: Icon(Icons.arrow_drop_down, color: widget.foregroundColor!),
    );
  }
}
