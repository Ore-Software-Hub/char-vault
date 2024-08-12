import 'dart:math';
import 'package:CharVault/components/button_component.dart';
import 'package:flutter/material.dart';
import 'package:CharVault/constants/cores.constants.dart' as cores;

class DiceBottomSheetComponent extends StatefulWidget {
  const DiceBottomSheetComponent({super.key});

  @override
  _DiceBottomSheetComponentState createState() =>
      _DiceBottomSheetComponentState();
}

class _DiceBottomSheetComponentState extends State<DiceBottomSheetComponent> {
  double sheetHeight = 350;

  String total = "";
  List<int> dices = [];
  String diceValues = "Selecione os dados";

  @override
  void initState() {
    super.initState();
  }

  addDice(int value) {
    String vals = "";

    if (dices.length >= 4) {
      return;
    }

    setState(() {
      dices.add(value);
    });

    for (var i = 0; i < dices.length; i++) {
      var dice = dices[i];
      vals += "D${dice.toInt()}";
      if (i != dices.length - 1) {
        vals += " + ";
      }
    }

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
    List<int> sum = [];
    String subtotal = "";

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
        sum.add(random.nextInt(key) + 1);
      }
    });

    for (var num in sum) {
      subtotal += "$num + ";
    }

    subtotal = subtotal.substring(0, subtotal.length - 2); // Remove última +
    subtotal +=
        "= ${sum.fold(0, (previousValue, element) => previousValue + element)}";

    setState(() {
      total = subtotal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(
              color: cores.secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(15))),
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
                  spacing: 4.0, // Espaçamento horizontal entre os widgets
                  runSpacing: 4.0, // Espaçamento vertical entre as linhas
                  children: [
                    ButtonComponent(
                        pressed: () {
                          addDice(4);
                        },
                        label: "D4"),
                    ButtonComponent(
                        pressed: () {
                          addDice(6);
                        },
                        label: "D6"),
                    ButtonComponent(
                        pressed: () {
                          addDice(8);
                        },
                        label: "D8"),
                    ButtonComponent(
                        pressed: () {
                          addDice(10);
                        },
                        label: "D10"),
                    ButtonComponent(
                        pressed: () {
                          addDice(12);
                        },
                        label: "D12"),
                    ButtonComponent(
                        pressed: () {
                          addDice(20);
                        },
                        label: "D20"),
                    ButtonComponent(
                        pressed: () {
                          addDice(100);
                        },
                        label: "D100"),
                    ButtonComponent(
                      pressed: () {
                        removeDice();
                      },
                      label: "X",
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    children: [
                      Text(
                        diceValues,
                        maxLines: 2,
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
                ButtonComponent(
                    pressed: () {
                      calculate();
                    },
                    disabled: dices.isEmpty,
                    label: "Rolar")
              ],
            ),
          ),
        ));
  }
}
