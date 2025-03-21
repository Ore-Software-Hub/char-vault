import 'package:CharVault/components/bottomsheet/card.bs.component.dart';
import 'package:CharVault/components/bottomsheet/items.bs.component.dart';
import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/components/card.component.dart';
import 'package:CharVault/components/header.component.dart';
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

class BackPackPage extends StatefulWidget {
  const BackPackPage({super.key});

  @override
  State<BackPackPage> createState() => _BackPackPageState();
}

class _BackPackPageState extends State<BackPackPage> {
  List<ItemModel> _inventory = [];
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
      if (item.tipo != 'Arma' &&
          item.tipo != 'Magia' &&
          item.tipo != 'Armadura') {
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
                    "Dinheiro",
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
                  children: _char!.currency.map<CardComponent>((curr) {
                    return CardComponent(
                      top: InkWell(
                        onTap: () async {
                          final newAmount = await showModalBottomSheet<int>(
                            showDragHandle: true,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => CardBSComponent(
                              title: curr.type,
                              amount: curr.amount,
                            ),
                          );

                          if (newAmount != null) {
                            setState(() {
                              curr.amount = newAmount;
                            });
                            await DatabaseService.updateCharacter(
                                _char!.id, _char!.toMap());
                          }
                        },
                        child: Text(
                          "${curr.amount}pç",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      bottom: Text(
                        curr.type,
                        style: AppTextStyles.lightText(context,
                            size: 12,
                            color: Theme.of(context).colorScheme.onSurface),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList())
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SectionComponent(
              title: 'Itens',
              list: _inventory,
              selectedItem: (index) {
                showModalBottomSheet(
                  context: context,
                  useSafeArea: true,
                  isScrollControlled: true,
                  showDragHandle: false,
                  barrierColor: Color.fromARGB(255, 229, 201, 144),
                  builder: (context) =>
                      ItemsBSComponent(item: _inventory[index]),
                );
              },
              removeItem: (index) async {
                await DatabaseService.deleteItem(
                    _char!.id, _inventory[index].id);
                setState(() {
                  _inventory.removeAt(index);
                });
                Provider.of<LoginProvider>(context, listen: false)
                    .updateUser(char: _char);
              },
              buttonAdd: ButtonComponent(
                pressed: () async {
                  ItemModel? resultado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddItemPage(),
                    ),
                  );

                  if (resultado != null) {
                    try {
                      await DatabaseService.addItem(_char!.id, resultado);
                      setState(() {
                        _inventory.add(resultado);
                      });
                      NotificationHelper.showSnackBar(
                          context, "Item Adicionado",
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
