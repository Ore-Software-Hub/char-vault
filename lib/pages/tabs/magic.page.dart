import 'dart:convert';

import 'package:CharVault/components/bottomsheet/items.bs.component.dart';
import 'package:CharVault/components/bottomsheet/select_magic.bs.component.dart';
import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/components/card.component.dart';
import 'package:CharVault/components/header.component.dart';
import 'package:CharVault/components/section.component.dart';
import 'package:CharVault/constants/strings.constants.dart';
import 'package:CharVault/helpers/notification.helper.dart';
import 'package:CharVault/helpers/shared_preferences.helper.dart';
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
  List<ItemModel> _magic = [];
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
      if (item.tipo == 'Magia') {
        items.add(item);
      }
    }

    if (mounted) {
      setState(() {
        _magic = items;
        loading = false;
      });
    }

    var shared = await SharedPreferencesHelper.getData(
        'string', Constants.selectedMagic);

    try {
      List<dynamic> jsonList = jsonDecode(shared);
      var itemList = jsonList.map((item) => ItemModel.fromMap(item)).toList();
      setState(() {
        _selectedMagic = itemList;
      });
    } catch (e) {}
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
                    style: AppTextStyles.boldText(context,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
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
                            String selected = jsonEncode(
                                _selectedMagic.map((m) => m.toMap()).toList());
                            SharedPreferencesHelper.setData(
                                'string', Constants.selectedMagic, selected);
                          },
                          child: Text(
                            _selectedMagic[index].title,
                            style: AppTextStyles.boldText(
                              context,
                              color: Theme.of(context).colorScheme.primary,
                              size: 18,
                            ),
                          ),
                        ),
                        bottom: Text(
                          'Ativa',
                          style: AppTextStyles.lightText(context,
                              size: 12,
                              color: Theme.of(context).colorScheme.onSurface),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    } else {
                      return CardComponent(
                          top: InkWell(
                              onTap: () async {
                                ItemModel? selected =
                                    await showModalBottomSheet(
                                  context: context,
                                  useSafeArea: true,
                                  isScrollControlled: true,
                                  showDragHandle: false,
                                  builder: (context) =>
                                      SelectMagicBSComponent(list: _magic),
                                );

                                if (selected != null) {
                                  setState(() {
                                    _selectedMagic.add(selected);
                                  });
                                  String selectedT = jsonEncode(_selectedMagic
                                      .map((m) => m.toMap())
                                      .toList());
                                  SharedPreferencesHelper.setData('string',
                                      Constants.selectedMagic, selectedT);
                                }
                              },
                              child: Container()),
                          bottom: Container());
                    }
                  }))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SectionComponent(
              title: 'Magias',
              list: _magic,
              selectedItem: (index) {
                showModalBottomSheet(
                  context: context,
                  useSafeArea: true,
                  isScrollControlled: true,
                  showDragHandle: false,
                  barrierColor: Color.fromARGB(255, 229, 201, 144),
                  builder: (context) =>
                      ItemsBSComponent(item: _magic[index]),
                );
              },
              removeItem: (index) async {
                await DatabaseService.deleteItem(
                    _char!.id, _magic[index].id);
                setState(() {
                  _magic.removeAt(index);
                });
                Provider.of<LoginProvider>(context, listen: false)
                    .updateUser(char: _char);
              },
              buttonAdd: ButtonComponent(
                pressed: () async {
                  ItemModel? resultado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddItemPage(
                        type: 'magic',
                      ),
                    ),
                  );

                  if (resultado != null) {
                    try {
                      await DatabaseService.addItem(_char!.id, resultado);
                      setState(() {
                        _magic.add(resultado);
                      });
                      NotificationHelper.showSnackBar(
                          context, "Magia Adicionada",
                          level: 'success');
                    } catch (e) {
                      NotificationHelper.showSnackBar(
                          context, "Erro: ${e.toString()}",
                          level: 'error');
                    }
                  }
                },
                tipo: 3,
                icon: PhosphorIconsBold.plus,
              )),
        ),
      ],
    );
  }
}
