import 'dart:math';

import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int dice = 6;
  int diceQty = 1;
  int rollResult = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Rolar Dados",
            style: AppTextStyles.boldText(context,
                size: 20, color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$rollResult',
                style: AppTextStyles.boldText(context,
                    size: 72, color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      indent: 10, // Espaço entre a linha e a letra
                      endIndent: 20, // Espaço entre a linha e a letra
                    ),
                  ),
                  Text(
                    'd$dice',
                    style: AppTextStyles.lightText(context,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  const Expanded(
                    child: Divider(
                      indent: 20, // Espaço entre a linha e a letra
                      endIndent: 10, // Espaço entre a linha e a letra
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonComponent(
                        selected: dice == 4,
                        tipo: 2,
                        pressed: () => {
                          setState(() {
                            dice = 4;
                          })
                        },
                        label: '4',
                      ),
                      ButtonComponent(
                        selected: dice == 6,
                        tipo: 2,
                        pressed: () => {
                          setState(() {
                            dice = 6;
                          })
                        },
                        label: '6',
                      ),
                      ButtonComponent(
                        selected: dice == 8,
                        tipo: 2,
                        pressed: () => {
                          setState(() {
                            dice = 8;
                          })
                        },
                        label: '8',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonComponent(
                        selected: dice == 12,
                        tipo: 2,
                        pressed: () => {
                          setState(() {
                            dice = 12;
                          })
                        },
                        label: '12',
                      ),
                      ButtonComponent(
                        selected: dice == 20,
                        tipo: 2,
                        pressed: () => {
                          setState(() {
                            dice = 20;
                          })
                        },
                        label: '20',
                      ),
                      ButtonComponent(
                        selected: dice == 100,
                        tipo: 2,
                        pressed: () => {
                          setState(() {
                            dice = 100;
                          })
                        },
                        label: '%',
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ButtonComponent(
                tipo: 1,
                icon: PhosphorIconsBold.diceFive,
                pressed: () {
                  var result = 0;
                  for (var i = 0; i < diceQty; i++) {
                    result += Random().nextInt(dice) + 1;
                  }
                  setState(() {
                    rollResult = result;
                  });
                },
                label: 'Rolar Dados',
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonComponent(
                      pressed: () {
                        setState(() {
                          diceQty = max(1, diceQty - 1);
                        });
                      },
                      label: '-1',
                    ),
                    Text(
                      '${diceQty}d$dice',
                      style: AppTextStyles.boldText(context,
                          size: 20,
                          color: Theme.of(context).colorScheme.surface),
                    ),
                    ButtonComponent(
                      pressed: () => {
                        setState(() {
                          diceQty++;
                        })
                      },
                      label: '+1',
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
