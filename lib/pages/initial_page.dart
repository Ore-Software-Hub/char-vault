import 'dart:math';

import 'package:character_vault/pages/home_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:character_vault/constants/cores.constants.dart' as cores;

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  int _selectedIndex = 0;

  List<Widget> tabs = [const HomePage()];
  List<String> tabsNames = ["Início", "Inventário", "Combate", "Perfil"];

  @override
  void initState() {
    super.initState();
    // isUser = Provider.of<LoginProvider>(context, listen: false).userLogged;
    // if (isUser == null) {
    //   Navigator.pop(context);
    // }
    // loadUser();
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(child: tabs[_selectedIndex]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => const MapBottomSheet());
        },
        child: const PhosphorIcon(
          PhosphorIconsBold.diceFive,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        animationDuration: const Duration(milliseconds: 200),
        backgroundColor: Colors.white,
        color: cores.gray,
        // onTap: _onItemTapped,
        items: const [
          PhosphorIcon(
            PhosphorIconsBold.house,
          ),
          PhosphorIcon(
            PhosphorIconsBold.backpack,
          ),
          PhosphorIcon(
            PhosphorIconsBold.handFist,
          ),
          PhosphorIcon(
            PhosphorIconsBold.user,
          ),
        ],
      ),
    );
  }
}

class MapBottomSheet extends StatefulWidget {
  const MapBottomSheet({super.key});

  @override
  _MapBottomSheetState createState() => _MapBottomSheetState();
}

class _MapBottomSheetState extends State<MapBottomSheet> {
  double sheetHeight = 400;

  String total = "";
  List<int> dices = [];
  String diceValues = "Selecione os dados";

  @override
  void initState() {
    super.initState();
  }

  addDice(int value) {
    String vals = "";

    setState(() {
      dices.add(value);
    });
    for (var i = 0; i < dices.length; i++) {
      var dice = dices[i];
      vals += "D${dice.toInt()}";
      if (i != dices.length - 1) {
        vals += "+";
      }
    }
    debugPrint(vals);
    setState(() {
      diceValues = vals;
      total = "";
    });
  }

  removeDice() {
    setState(() {
      dices.clear();
      diceValues = "Selecione os dados";
      total = "";
    });
  }

  calculate() {
    var random = Random();
    int sum = 0;

    Map<int, int> countMap = {};

    for (var number in dices) {
      if (countMap.containsKey(number)) {
        countMap[number] = countMap[number]! + 1;
      } else {
        countMap[number] = 1;
      }
    }

    countMap.forEach((key, value) {
      for (int i = 0; i < value; i++) {
        sum += random.nextInt(key) + 1;
      }
    });

    setState(() {
      total = sum.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color: cores.secondaryColor,
          height: sheetHeight,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
            child: Column(
              children: [
                const Text(
                  "Rolar Dados",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8.0, // Espaçamento horizontal entre os widgets
                  runSpacing: 4.0, // Espaçamento vertical entre as linhas
                  children: [
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            overlayColor:
                                WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.pressed)) {
                                  return cores
                                      .secondaryColor; // Altere para a cor desejada
                                }
                                return null; // Use o valor padrão para outros estados
                              },
                            ),
                            foregroundColor:
                                const WidgetStatePropertyAll(Colors.white),
                            backgroundColor: const WidgetStatePropertyAll(
                                cores.primaryColor)),
                        onPressed: () {
                          addDice(2);
                        },
                        icon: const PhosphorIcon(
                          PhosphorIconsBold.diceTwo,
                        ),
                        label: const Text("D2")),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            overlayColor:
                                WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.pressed)) {
                                  return cores
                                      .secondaryColor; // Altere para a cor desejada
                                }
                                return null; // Use o valor padrão para outros estados
                              },
                            ),
                            foregroundColor:
                                const WidgetStatePropertyAll(Colors.white),
                            backgroundColor: const WidgetStatePropertyAll(
                                cores.primaryColor)),
                        onPressed: () {
                          addDice(4);
                        },
                        icon: const PhosphorIcon(
                          PhosphorIconsBold.diceFour,
                        ),
                        label: const Text("D4")),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            overlayColor:
                                WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.pressed)) {
                                  return cores
                                      .secondaryColor; // Altere para a cor desejada
                                }
                                return null; // Use o valor padrão para outros estados
                              },
                            ),
                            foregroundColor:
                                const WidgetStatePropertyAll(Colors.white),
                            backgroundColor: const WidgetStatePropertyAll(
                                cores.primaryColor)),
                        onPressed: () {
                          addDice(6);
                        },
                        icon: const PhosphorIcon(
                          PhosphorIconsBold.diceSix,
                        ),
                        label: const Text("D6")),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            overlayColor:
                                WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.pressed)) {
                                  return cores
                                      .secondaryColor; // Altere para a cor desejada
                                }
                                return null; // Use o valor padrão para outros estados
                              },
                            ),
                            foregroundColor:
                                const WidgetStatePropertyAll(Colors.white),
                            backgroundColor: const WidgetStatePropertyAll(
                                cores.primaryColor)),
                        onPressed: () {
                          addDice(10);
                        },
                        icon: const PhosphorIcon(
                          PhosphorIconsBold.diceTwo,
                        ),
                        label: const Text("D10")),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            overlayColor:
                                WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.pressed)) {
                                  return cores
                                      .secondaryColor; // Altere para a cor desejada
                                }
                                return null; // Use o valor padrão para outros estados
                              },
                            ),
                            foregroundColor:
                                const WidgetStatePropertyAll(Colors.white),
                            backgroundColor: const WidgetStatePropertyAll(
                                cores.primaryColor)),
                        onPressed: () {
                          addDice(12);
                        },
                        icon: const PhosphorIcon(
                          PhosphorIconsBold.diceTwo,
                        ),
                        label: const Text("D12")),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            overlayColor:
                                WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.pressed)) {
                                  return cores
                                      .secondaryColor; // Altere para a cor desejada
                                }
                                return null; // Use o valor padrão para outros estados
                              },
                            ),
                            foregroundColor:
                                const WidgetStatePropertyAll(Colors.white),
                            backgroundColor: const WidgetStatePropertyAll(
                                cores.primaryColor)),
                        onPressed: () {
                          addDice(20);
                        },
                        icon: const PhosphorIcon(
                          PhosphorIconsBold.diceTwo,
                        ),
                        label: const Text("D20")),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            overlayColor:
                                WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.pressed)) {
                                  return cores
                                      .secondaryColor; // Altere para a cor desejada
                                }
                                return null; // Use o valor padrão para outros estados
                              },
                            ),
                            foregroundColor:
                                const WidgetStatePropertyAll(Colors.white),
                            backgroundColor: const WidgetStatePropertyAll(
                                cores.primaryColor)),
                        onPressed: () {
                          addDice(100);
                        },
                        icon: const PhosphorIcon(
                          PhosphorIconsBold.diceTwo,
                        ),
                        label: const Text("D100")),
                    ElevatedButton(
                        style: ButtonStyle(
                            overlayColor:
                                WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.pressed)) {
                                  return cores
                                      .secondaryColor; // Altere para a cor desejada
                                }
                                return null; // Use o valor padrão para outros estados
                              },
                            ),
                            foregroundColor:
                                const WidgetStatePropertyAll(Colors.white),
                            backgroundColor: const WidgetStatePropertyAll(
                                cores.primaryColor)),
                        onPressed: () {
                          removeDice();
                        },
                        child: const Text("X"))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Column(
                    children: [
                      Text(
                        diceValues,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      const Divider(
                        indent: 50,
                        endIndent: 50,
                        height: 0,
                        color: Colors.white,
                      ),
                      Text(
                        total,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                    style: ButtonStyle(
                        overlayColor: WidgetStateProperty.resolveWith<Color?>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.pressed)) {
                              return cores
                                  .secondaryColor; // Altere para a cor desejada
                            }
                            return null; // Use o valor padrão para outros estados
                          },
                        ),
                        foregroundColor:
                            const WidgetStatePropertyAll(Colors.white),
                        backgroundColor:
                            const WidgetStatePropertyAll(cores.primaryColor)),
                    onPressed: () {
                      calculate();
                    },
                    icon: const PhosphorIcon(
                      PhosphorIconsBold.arrowClockwise,
                    ),
                    label: const Text("Rolar"))
              ],
            ),
          ),
        ));
  }
}
