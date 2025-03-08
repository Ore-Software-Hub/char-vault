import 'package:CharVault/helpers/notification_helper.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:CharVault/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ItemComponent extends StatefulWidget {
  const ItemComponent(
      {super.key, required this.item, required this.charId, this.icon});

  final ItemModel item;
  final String charId;
  final PhosphorIconData? icon;

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
                color: Colors.grey, // Sem preenchimento
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
            onTap: widget.charId.isEmpty
                ? null
                : () async {
                    // final item = await showModalBottomSheet<ItemModel?>(
                    //   backgroundColor: Theme.of(context).colorScheme.secondary,
                    //   showDragHandle: true,
                    //   context: context,
                    //   isScrollControlled: true,
                    //   builder: (context) => AddItemBottomSheetComponent(
                    //     editing: true,
                    //     item: widget.item,
                    //   ),
                    // );

                    // if (item != null) {
                    //   await DatabaseService.updateItem(
                    //       widget.charId, widget.item.id, item.toMap());
                    //   NotificationHelper.showSnackBar(
                    //       context, "Item atualizado");
                    // }
                  },
            child: Container(
              height: 40,
              padding: const EdgeInsets.only(left: 8, right: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey, // Sem preenchimento
                borderRadius: BorderRadius.circular(8.0), // Raio da borda
              ),
              child: Text(
                widget.item.title,
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
        if (widget.item.value.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4),
            child: Container(
              height: 40,
              width: 64,
              padding: const EdgeInsets.only(left: 8, right: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey, // Sem preenchimento
                borderRadius: BorderRadius.circular(8.0), // Raio da borda
              ),
              child: Text(
                widget.item.value,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
