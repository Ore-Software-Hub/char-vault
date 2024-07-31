import 'package:CharVault/components/bottomsheet/add_item_component.dart';
import 'package:CharVault/components/button_component.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:CharVault/constants/cores.constants.dart' as cores;

class ItemComponent extends StatefulWidget {
  const ItemComponent({
    super.key,
    required this.title,
    required this.tipo,
    this.value,
    this.icon,
  });

  final String title;
  final String? value;
  final PhosphorFlatIconData? icon;
  final int tipo;

  @override
  State<ItemComponent> createState() => _ItemComponentState();
}

class _ItemComponentState extends State<ItemComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (widget.icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: cores.gray, // Sem preenchimento
                borderRadius: BorderRadius.circular(50.0), // Raio da borda
              ),
              child: PhosphorIcon(
                widget.icon!,
                size: 30,
              ),
            ),
          ),
        Expanded(
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: cores.secondaryColor,
                showDragHandle: true,
                context: context,
                isScrollControlled: true,
                builder: (context) => const AddItemBottomSheetComponent(
                  editing: true,
                ),
              );
            },
            child: Container(
              height: 40,
              padding: const EdgeInsets.only(left: 8, right: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: cores.gray, // Sem preenchimento
                borderRadius: BorderRadius.circular(8.0), // Raio da borda
              ),
              child: Text(
                widget.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        if (widget.value != null)
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4),
            child: Container(
              height: 40,
              width: 64,
              padding: const EdgeInsets.only(left: 8, right: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: cores.gray, // Sem preenchimento
                borderRadius: BorderRadius.circular(8.0), // Raio da borda
              ),
              child: Text(
                widget.value!,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ButtonComponent(pressed: () {}, tipo: 0, icon: PhosphorIconsBold.minus)
      ],
    );
  }
}
