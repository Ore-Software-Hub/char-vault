import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/components/card.component.dart';
import 'package:CharVault/models/character_model.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CurrencyBSComponent extends StatefulWidget {
  const CurrencyBSComponent({
    super.key,
    required this.currency,
  });

  final Currency currency;

  @override
  State<CurrencyBSComponent> createState() => _CurrencyBSComponentState();
}

class _CurrencyBSComponentState extends State<CurrencyBSComponent> {
  int amount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      amount = widget.currency.amount;
    });
  }

  void onAmountChanged(int newAmount) {
    var newVal = max(0, amount + newAmount);
    setState(() {
      amount = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CardComponent(
              top: Text(
                "${amount}pç",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),
              bottom: Text(widget.currency.type)),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonComponent(
                pressed: () => onAmountChanged(-5),
                label: "-5",
              ),
              const SizedBox(width: 3),
              ButtonComponent(
                pressed: () => onAmountChanged(-1),
                label: "-1",
              ),
              const SizedBox(width: 10),
              ButtonComponent(
                pressed: () => onAmountChanged(1),
                label: "+1",
              ),
              const SizedBox(width: 3),
              ButtonComponent(
                pressed: () => onAmountChanged(5),
                label: "+5",
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonComponent(
                pressed: () => Navigator.pop(context),
                label: "Cancelar",
                tipo: 1,
                icon: PhosphorIconsBold.x,
              ),
              ButtonComponent(
                pressed: () => Navigator.pop(context, amount),
                label: "Salvar",
                tipo: 1,
                icon: PhosphorIconsBold.floppyDisk,
              ),
            ],
          )
        ],
      ),
    );
  }
}
