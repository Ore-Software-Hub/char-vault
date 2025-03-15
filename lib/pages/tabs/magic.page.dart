import 'package:CharVault/components/button_component.dart';
import 'package:CharVault/components2/card.component.dart';
import 'package:CharVault/components2/header.component.dart';
import 'package:CharVault/components2/section.component.dart';
import 'package:CharVault/helpers/notification_helper.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:CharVault/pages/add_item.page.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:CharVault/services/database_service.dart';
import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class MagicPage extends StatefulWidget {
  const MagicPage({super.key});

  @override
  State<MagicPage> createState() => _MagicPageState();
}

class _MagicPageState extends State<MagicPage> {
  List<ItemModel> _inventory = [];
  List<ItemModel> _selectedMagic = [];
  CharacterModel? _char;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _char = Provider.of<LoginProvider>(context, listen: false).userModel!.char;
    loadItems();
  }

  loadItems() async {
    List<ItemModel> items = [];
    var charItems = await DatabaseService.getCharItems(_char!.id);

    for (var item in charItems) {
      if (item.tipo != 'Arma') {
        items.add(item);
      }
    }

    if (mounted) {
      setState(() {
        _inventory = items;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderComponent(
          type: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Espaços de Magias",
                    style: AppTextStyles.boldText(context, size: 20),
                  ),
                  ButtonComponent(
                    pressed: () => {},
                    tipo: 0,
                    icon: PhosphorIconsBold.plus,
                  )
                ],
              ),
              Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  spacing: 4.0, // Espaçamento horizontal entre os widgets
                  runSpacing: 8.0, // Espaçamento vertical entre as linhas
                  children: List.generate(4, (index) {
                    if (index < _selectedMagic.length) {
                      return CardComponent(
                        top: InkWell(
                          onTap: () async {
                            setState(() {
                              _selectedMagic.removeAt(index);
                            });
                          },
                          child: Text(
                            _selectedMagic[index].quantity,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        bottom: Text(
                          _selectedMagic[index].title,
                          style: AppTextStyles.lightText(context, size: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    } else {
                      return CardComponent(
                          top: Container(), bottom: Container());
                    }
                  }))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SectionComponent(
              title: 'Magias',
              list: _inventory,
              pressed: (index) {
                setState(() {
                  var magic = _inventory[index];
                  if (!_selectedMagic.contains(magic)) {
                    _selectedMagic.add(magic);
                  }
                });
              },
              buttonAdd: ButtonComponent(
                pressed: () async {
                  ItemModel? resultado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddItemPage(),
                    ),
                  );

                  String? itemId;

                  if (resultado != null) {
                    try {
                      itemId =
                          await DatabaseService.addItem(_char!.id, resultado);
                      _inventory.add(resultado);
                    } catch (e) {
                      NotificationHelper.showSnackBar(context,
                          "Item ${itemId != null ? "Adicionado" : "Não adicionado"}",
                          level: itemId != null ? 1 : 0);
                    }
                  }
                },
                tipo: 0,
                icon: PhosphorIconsBold.plus,
              )),
        ),
      ],
    );
  }
}
