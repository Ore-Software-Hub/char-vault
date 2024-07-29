import 'package:flutter/material.dart';

class DropdownComponent extends StatefulWidget {
  const DropdownComponent({
    super.key,
    required this.onChanged,
    this.hintText,
  });

  final Function(String?) onChanged;
  final String? hintText;

  @override
  State<DropdownComponent> createState() => _DropdownComponentState();
}

class _DropdownComponentState extends State<DropdownComponent> {
  String? selectedValue;
  List<String> items = ["Armadura", "Ferramenta", "Arma", "Magia"];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      hint: const Text(
        "Tipo",
        style: TextStyle(color: Colors.white),
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue;
        });
        widget.onChanged(newValue); // Chama a função de callback
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
      ),
      dropdownColor: Theme.of(context).colorScheme.secondary,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
    );
  }
}
