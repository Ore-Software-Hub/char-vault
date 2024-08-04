import 'package:CharVault/components/header_component.dart';
import 'package:CharVault/components/item_component.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FightPage extends StatefulWidget {
  const FightPage({super.key});

  @override
  State<FightPage> createState() => _FightPageState();
}

class _FightPageState extends State<FightPage> {
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
            const HeaderComponent(
              type: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
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
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 4.0, // Espaçamento horizontal entre os widgets
                    runSpacing: 4.0, // Espaçamento vertical entre as linhas
                    children: [
                      ItemComponent(
                        icon: PhosphorIconsRegular.sword,
                        item: ItemModel(
                            "id", "title", "value", "description", "tipo"),
                      ),
                      ItemComponent(
                        icon: PhosphorIconsRegular.sword,
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
                    "Magias",
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
                        icon: PhosphorIconsRegular.lightning,
                        item: ItemModel(
                            "id", "title", "value", "description", "tipo"),
                      ),
                      ItemComponent(
                        icon: PhosphorIconsRegular.lightning,
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
