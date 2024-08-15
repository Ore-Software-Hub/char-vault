import 'package:CharVault/components/button_component.dart';
import 'package:CharVault/components/header_component.dart';
import 'package:CharVault/components/item_component.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:CharVault/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class BackPackPage extends StatefulWidget {
  const BackPackPage({super.key});

  @override
  State<BackPackPage> createState() => _BackPackPageState();
}

class _BackPackPageState extends State<BackPackPage> {
  List<ItemModel> _equipments = [], _inventory = [];
  CharacterModel? _char;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _char = Provider.of<LoginProvider>(context, listen: false).userModel!.char;
    loadItems();
  }

  loadItems() async {
    List<ItemModel> equipments = [];
    List<ItemModel> inventory = [];
    var items = await DatabaseService.getCharItems(_char!.id);
    for (var item in items) {
      switch (item.tipo) {
        case 'Armadura':
        case 'Equipamento':
        case 'Item':
          equipments.add(item);
          break;

        case 'Consumíveis':
        case 'Item mágico':
        case 'Objeto':
        case 'Outros':
          inventory.add(item);
          break;
      }
    }

    setState(() {
      _equipments = equipments;
      _inventory = inventory;
      loading = false;
    });
  }

  Widget returnItemComponent(List<ItemModel> items) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0, // Espaçamento horizontal entre os widgets
      runSpacing: 4.0, // Espaçamento vertical entre as linhas
      children: items.map<Row>((item) {
        return Row(
          children: [
            Expanded(
              child: ItemComponent(
                charId: _char!.id,
                item: item,
              ),
            ),
            ButtonComponent(
                pressed: () async {
                  setState(() {
                    items.remove(item);
                  });
                  await DatabaseService.deleteItem(_char!.id, item.id);
                },
                tipo: 0,
                icon: PhosphorIconsBold.minus)
          ],
        );
      }).toList(),
    );
  }

  Widget returnInformation(String text, String subtext) {
    return Row(
      children: [
        const SizedBox(
          height: 50,
          width: 50,
          child: PhosphorIcon(PhosphorIconsBold.placeholder),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(subtext),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderComponent(),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Equipamentos",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  loading
                      ? Center(
                          child: LoadingAnimationWidget.twistingDots(
                              leftDotColor:
                                  Theme.of(context).colorScheme.primary,
                              rightDotColor:
                                  Theme.of(context).colorScheme.secondary,
                              size: 30),
                        )
                      : _equipments.isEmpty
                          ? returnInformation("Nenhum equipamento encontrado!",
                              "Adicione um novo!")
                          : returnItemComponent(_equipments)
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Inventário",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  loading
                      ? Center(
                          child: LoadingAnimationWidget.twistingDots(
                              leftDotColor:
                                  Theme.of(context).colorScheme.primary,
                              rightDotColor:
                                  Theme.of(context).colorScheme.secondary,
                              size: 30),
                        )
                      : _inventory.isEmpty
                          ? returnInformation(
                              "Nenhum item encontrado!", "Adicione um novo!")
                          : returnItemComponent(_inventory)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
