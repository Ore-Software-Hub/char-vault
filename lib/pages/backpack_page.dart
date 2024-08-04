import 'package:CharVault/components/header_component.dart';
import 'package:CharVault/components/item_component.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BackPackPage extends StatefulWidget {
  const BackPackPage({super.key});

  @override
  State<BackPackPage> createState() => _BackPackPageState();
}

class _BackPackPageState extends State<BackPackPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderComponent(type: 1),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
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
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 4.0, // Espaçamento horizontal entre os widgets
                    runSpacing: 4.0, // Espaçamento vertical entre as linhas
                    children: [
                      ItemComponent(
                        icon: PhosphorIconsRegular.shield,
                        item: ItemModel(
                            "id", "title", "value", "description", "tipo"),
                      ),
                      ItemComponent(
                        icon: PhosphorIconsRegular.shovel,
                        item: ItemModel(
                            "id", "title", "value", "description", "tipo"),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
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
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 4.0, // Espaçamento horizontal entre os widgets
                    runSpacing: 4.0, // Espaçamento vertical entre as linhas
                    children: [
                      ItemComponent(
                        item: ItemModel(
                            "id", "title", "value", "description", "tipo"),
                        icon: PhosphorIconsRegular.champagne,
                      ),
                      ItemComponent(
                        icon: PhosphorIconsRegular.champagne,
                        item: ItemModel(
                            "id", "title", "value", "description", "tipo"),
                      ),
                      ItemComponent(
                        icon: PhosphorIconsRegular.dotsNine,
                        item: ItemModel(
                            "id", "title", "value", "description", "tipo"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
