import 'package:character_vault/components/button/iconb_component.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:character_vault/constants/cores.constants.dart' as cores;

class ItemComponent extends StatefulWidget {
  const ItemComponent({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String? value;
  final PhosphorFlatIconData icon;
  final VoidCallback onTap;

  @override
  State<ItemComponent> createState() => _ItemComponentState();
}

class _ItemComponentState extends State<ItemComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: cores.gray, // Sem preenchimento
            borderRadius: BorderRadius.circular(50.0), // Raio da borda
          ),
          child: PhosphorIcon(
            widget.icon,
            size: 30,
          ),
        ),
        const SizedBox(width: 8), // Espaçamento entre icone e título
        InkWell(
          onTap: widget.onTap,
          child: Container(
            width: MediaQuery.of(context).size.width / 2.25,
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
        const SizedBox(width: 4),
        widget.value != null
            ? Container(
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
              )
            : Container(
                height: 40,
                width: 64,
                padding: const EdgeInsets.only(left: 8, right: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: cores.gray, // Sem preenchimento
                  borderRadius: BorderRadius.circular(8.0), // Raio da borda
                ),
              ),
        const SizedBox(width: 4),
        IconButtonComponent(pressed: () {}, icon: PhosphorIconsBold.minus)
      ],
    );
  }
}
