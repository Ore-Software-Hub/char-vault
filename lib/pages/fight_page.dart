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

class FightPage extends StatefulWidget {
  const FightPage({super.key});

  @override
  State<FightPage> createState() => _FightPageState();
}

class _FightPageState extends State<FightPage> {
  List<ItemModel> _weapons = [], _spells = [];
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
    List<ItemModel> spells = [];
    var items = await DatabaseService.getCharItemModels(_char!.id);
    for (var item in items) {
      switch (item.tipo) {
        case 'Arma':
          weapons.add(item);
          break;

        case 'Magia':
          spells.add(item);
          break;
      }
    }
    setState(() {
      _weapons = weapons;
      _spells = spells;
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
                item: item,
              ),
            ),
            ButtonComponent(
                pressed: () {
                  setState(() {
                    items.remove(item);
                  });
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
                    "Armas",
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
                      : _weapons.isEmpty
                          ? returnInformation(
                              "Nenhuma arma encontrada!", "Adicione uma nova!")
                          : returnItemComponent(_weapons)
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
                    "Magias",
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
                      : _weapons.isEmpty
                          ? returnInformation(
                              "Nenhuma magia encontrada!", "Adicione uma nova!")
                          : returnItemComponent(_spells)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
