import 'package:CharVault/components/header_component.dart';
import 'package:CharVault/components/item_component.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FightPage extends StatefulWidget {
  const FightPage({super.key});

  @override
  State<FightPage> createState() => _FightPageState();
}

class _FightPageState extends State<FightPage> {
  String name = "Garry Floyd",
      classe = "Bardo",
      level = "1",
      curLife = "15/",
      maxLife = "17",
      pg = "15",
      pp = "15",
      pb = "15";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderComponent(
              user: null,
              type: 1,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
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
                          tipo: 2,
                          icon: PhosphorIconsRegular.sword,
                          title: "Espada larga",
                          value: "1D6"),
                      ItemComponent(
                          tipo: 2,
                          icon: PhosphorIconsRegular.sword,
                          title: "Besta leve",
                          value: "1D4"),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
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
                          tipo: 3,
                          icon: PhosphorIconsRegular.lightning,
                          title: "Canto sombrio",
                          value: "1D4"),
                      ItemComponent(
                          tipo: 3,
                          icon: PhosphorIconsRegular.lightning,
                          title: "Canto amoroso",
                          value: "2 turnos"),
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
