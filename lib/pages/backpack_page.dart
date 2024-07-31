import 'package:CharVault/components/header_component.dart';
import 'package:CharVault/components/item_component.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BackPackPage extends StatefulWidget {
  const BackPackPage({super.key});

  @override
  State<BackPackPage> createState() => _BackPackPageState();
}

class _BackPackPageState extends State<BackPackPage> {
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
            HeaderComponent(type: 1),
            Padding(
              padding: EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
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
                          tipo: 0,
                          icon: PhosphorIconsRegular.shield,
                          title: "Elmo Élfico",
                          value: "+2 def"),
                      ItemComponent(
                          tipo: 0,
                          icon: PhosphorIconsRegular.shovel,
                          title: "Machado Lunar",
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
                          tipo: 1,
                          icon: PhosphorIconsRegular.champagne,
                          title: "Poção de cura",
                          value: "x10"),
                      ItemComponent(
                          tipo: 1,
                          icon: PhosphorIconsRegular.champagne,
                          title: "Poção de velocidade",
                          value: "x3"),
                      ItemComponent(
                          tipo: 1,
                          icon: PhosphorIconsRegular.dotsNine,
                          title: "Chave enferrujada",
                          value: null),
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
