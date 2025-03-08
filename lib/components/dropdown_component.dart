import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DropdownComponent extends StatefulWidget {
  const DropdownComponent({
    super.key,
    required this.onChanged,
    required this.items,
    required this.value,
    this.hintText,
  });

  final Function(String?)? onChanged;
  final String? hintText;
  final List<ItemDropdown> items;
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
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
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
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      icon: PhosphorIcon(PhosphorIcons.caretDown(),
          color: Theme.of(context).colorScheme.onSurface),
    );
  }
}

class ItemDropdown {
  final String display;
  final dynamic value;

  ItemDropdown({required this.display, required this.value});
}
