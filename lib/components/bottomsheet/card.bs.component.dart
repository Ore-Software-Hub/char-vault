import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/components/card.component.dart';
import 'package:CharVault/components/textfield.component.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CardBSComponent extends StatefulWidget {
  const CardBSComponent({
    super.key,
    required this.amount,
    required this.title,
  });

  final int amount;
  final String title;

  @override
  State<CardBSComponent> createState() => _CardBSComponentState();
}

class _CardBSComponentState extends State<CardBSComponent> {
  int amount = 0;
  String title = '', strAmount = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      amount = widget.amount;
      title = widget.title;
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
                "$amount",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),
              bottom: Text(widget.title)),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFieldComponent(
                  label: title,
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setState(() {
                      strAmount = val;
                      onAmountChanged(int.parse(val));
                    });
                  },
                  value: strAmount),
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
