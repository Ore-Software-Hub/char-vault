import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/constants/strings.constants.dart';
import 'package:CharVault/helpers/shared_preferences.helper.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter/material.dart';

class ItemsBSComponent extends StatefulWidget {
  const ItemsBSComponent({
    super.key,
    required this.item,
  });

  final ItemModel item;

  @override
  State<ItemsBSComponent> createState() => _ItemsBSComponentState();
}

class _ItemsBSComponentState extends State<ItemsBSComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/img/scroll_bg.png'), fit: BoxFit.cover),
        color: Color.fromARGB(255, 231, 216, 190),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              Text(
                widget.item.title,
                style: AppTextStyles.boldText(context, size: 28),
              ),
              Text(
                widget.item.tipo,
                style: AppTextStyles.italicText(context),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                indent: 130,
                endIndent: 130,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.item.description,
                style: AppTextStyles.lightText(context),
              ),
            ],
          ),
          if (widget.item.tipo == 'Armadura')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonComponent(
                  pressed: () {
                    var val = int.parse(widget.item.value!);
                    SharedPreferencesHelper.setData(
                        'int', Constants.selectedArmor, val);
                    Navigator.pop(context, true);
                  },
                  label: 'Usar',
                )
              ],
            )
        ],
      ),
    );
  }
}
