import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/components/card.component.dart';
import 'package:CharVault/components/header.component.dart';
import 'package:CharVault/components/list.component.dart';
import 'package:CharVault/components/section.component.dart';
import 'package:CharVault/helpers/notification.helper.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:CharVault/pages/add_item.page.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:CharVault/services/database_service.dart';
import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class FightPage extends StatefulWidget {
  const FightPage({super.key});

  @override
  State<FightPage> createState() => _FightPageState();
}

class _FightPageState extends State<FightPage> {
  List<ItemModel> _weapons = [];
  CharacterModel? _char;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _char = Provider.of<LoginProvider>(context, listen: false).userModel!.char;
    loadItems();
  }

  loadItems() async {
    List<ItemModel> weapons = [];
    var items = await DatabaseService.getCharItems(_char!.id);
    for (var item in items) {
      switch (item.tipo) {
        case 'Arma':
          weapons.add(item);
          break;
      }
    }
    if (mounted) {
      setState(() {
        _weapons = weapons;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Informações",
                    style: AppTextStyles.boldText(context,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                spacing: 4.0, // Espaçamento horizontal entre os widgets
                runSpacing: 8.0, // Espaçamento vertical entre as linhas
                children: [
                  CardComponent(
                      top: InkWell(
                        onTap: () async {
                          // final newLifeVal = await showModalBottomSheet<String>(
                          //   backgroundColor:
                          //       Theme.of(context).colorScheme.secondary,
                          //   showDragHandle: true,
                          //   context: context,
                          //   isScrollControlled: true,
                          //   builder: (context) => EditLifeBottomSheetComponent(
                          //     curLife: _char!.curLife,
                          //     maxLife: _char!.maxLife,
                          //   ),
                          // );

                          // if (newLifeVal != null) {
                          //   setState(() {
                          //     _char!.curLife = newLifeVal;
                          //     Provider.of<LoginProvider>(context, listen: false)
                          //         .updateUser(char: _char);
                          //   });
                          //   await DatabaseService.updateCharacter(
                          //       _char!.id, _char!.toMap());
                          // }
                        },
                        child: Text(
                          "${_char!.details.armorClass}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      bottom: Text(
                        "Armadura",
                        style: AppTextStyles.lightText(context,
                            size: 12,
                            color: Theme.of(context).colorScheme.onSurface),
                        overflow: TextOverflow.ellipsis,
                      )),
                  CardComponent(
                      top: InkWell(
                        onTap: () async {
                          // final newLifeVal = await showModalBottomSheet<String>(
                          //   backgroundColor:
                          //       Theme.of(context).colorScheme.secondary,
                          //   showDragHandle: true,
                          //   context: context,
                          //   isScrollControlled: true,
                          //   builder: (context) => EditLifeBottomSheetComponent(
                          //     curLife: _char!.curLife,
                          //     maxLife: _char!.maxLife,
                          //   ),
                          // );

                          // if (newLifeVal != null) {
                          //   setState(() {
                          //     _char!.curLife = newLifeVal;
                          //     Provider.of<LoginProvider>(context, listen: false)
                          //         .updateUser(char: _char);
                          //   });
                          //   await DatabaseService.updateCharacter(
                          //       _char!.id, _char!.toMap());
                          // }
                        },
                        child: Text(
                          "1",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      bottom: Text(
                        "Iniciativa",
                        style: AppTextStyles.lightText(context,
                            size: 12,
                            color: Theme.of(context).colorScheme.onSurface),
                        overflow: TextOverflow.ellipsis,
                      )),
                  CardComponent(
                    top: InkWell(
                      onTap: () async {
                        // final newLifeVal = await showModalBottomSheet<String>(
                        //   backgroundColor:
                        //       Theme.of(context).colorScheme.secondary,
                        //   showDragHandle: true,
                        //   context: context,
                        //   isScrollControlled: true,
                        //   builder: (context) => EditLifeBottomSheetComponent(
                        //     curLife: _char!.curLife,
                        //     maxLife: _char!.maxLife,
                        //   ),
                        // );

                        // if (newLifeVal != null) {
                        //   setState(() {
                        //     _char!.curLife = newLifeVal;
                        //     Provider.of<LoginProvider>(context, listen: false)
                        //         .updateUser(char: _char);
                        //   });
                        //   await DatabaseService.updateCharacter(
                        //       _char!.id, _char!.toMap());
                        // }
                      },
                      child: Text(
                        "${_char!.details.movement}mt",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    bottom: Text(
                      "Deslocamento",
                      style: AppTextStyles.lightText(context,
                          size: 12,
                          color: Theme.of(context).colorScheme.onSurface),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SectionComponent(
              title: 'Armas',
              list: _weapons,
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
                      _weapons.add(resultado);
                    } catch (e) {
                      NotificationHelper.showSnackBar(context,
                          "Item ${itemId != null ? "Adicionado" : "Não adicionado"}",
                          level: itemId != null ? 1 : 0);
                    }
                  }
                },
                tipo: 3,
                icon: PhosphorIconsBold.plus,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 10,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Resistências & Imunidades",
                    style: AppTextStyles.boldText(context,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),
              ListComponent(
                  title: "Resistências", list: _char!.details.resistancies),
              ListComponent(
                  title: "Vulnerabilidades",
                  list: _char!.details.vulnerabilities),
              ListComponent(
                  title: "Imunidades", list: _char!.details.immunities),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Status",
                    style: AppTextStyles.boldText(context,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  ButtonComponent(
                    pressed: () => {},
                    tipo: 3,
                    icon: PhosphorIconsBold.plus,
                  )
                ],
              ),
              Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  spacing: 4.0, // Espaçamento horizontal entre os widgets
                  runSpacing: 8.0, // Espaçamento vertical entre as linhas
                  children: _char!.status.map<CardComponent>((stat) {
                    return CardComponent(
                      top: InkWell(
                        onTap: () async {
                          // final newLifeVal = await showModalBottomSheet<String>(
                          //   backgroundColor:
                          //       Theme.of(context).colorScheme.secondary,
                          //   showDragHandle: true,
                          //   context: context,
                          //   isScrollControlled: true,
                          //   builder: (context) => EditLifeBottomSheetComponent(
                          //     curLife: _char!.curLife,
                          //     maxLife: _char!.maxLife,
                          //   ),
                          // );

                          // if (newLifeVal != null) {
                          //   setState(() {
                          //     _char!.curLife = newLifeVal;
                          //     Provider.of<LoginProvider>(context, listen: false)
                          //         .updateUser(char: _char);
                          //   });
                          //   await DatabaseService.updateCharacter(
                          //       _char!.id, _char!.toMap());
                          // }
                        },
                        child: Text(
                          "${stat.value}x",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      bottom: Text(
                        stat.name,
                        style: AppTextStyles.lightText(context, size: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList())
            ],
          ),
        ),
        SizedBox(
          height: 100,
        )
      ],
    );
  }
}
