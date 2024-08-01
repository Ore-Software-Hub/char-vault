import 'package:flutter/material.dart';
import 'package:CharVault/constants/cores.constants.dart' as cores;

class DropdownComponent extends StatefulWidget {
  const DropdownComponent({
    super.key,
    required this.onChanged,
    required this.items,
    required this.value,
    this.hintText,
    this.backgroundColor = Colors.white,
    this.foregroundColor = cores.primaryColor,
  });

  final Function(String?)? onChanged;
  final String? hintText;
  final List<ItemDropdown> items;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String value;

  @override
  State<DropdownComponent> createState() => _DropdownComponentState();
}

class _DropdownComponentState extends State<DropdownComponent> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value.isEmpty ? null : widget.value;
  }

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
      items: widget.items.map<DropdownMenuItem<String>>((ItemDropdown obj) {
        return DropdownMenuItem<String>(
          value: obj.display,
          child: Text(
            obj.display,
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

class ItemDropdown {
  final String display;
  final dynamic value;

  ItemDropdown({required this.display, required this.value});
}
