import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/components/textfield.component.dart';
import 'package:CharVault/styles/font.styles.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LevelBSComponent extends StatefulWidget {
  const LevelBSComponent({
    super.key,
    required this.amount,
  });

  final String amount;

  @override
  State<LevelBSComponent> createState() => _LevelBSComponentState();
}

class _LevelBSComponentState extends State<LevelBSComponent> {
  String amount = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      amount = widget.amount;
    });
  }

  void onAmountChanged(int newAmount) {
    var newVal = max(0, newAmount);
    setState(() {
      amount = "$newVal";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 5),
                        width: amount.length * 30,
                        decoration: BoxDecoration(
                          color: Colors.transparent, // Sem preenchimento
                          borderRadius:
                              BorderRadius.circular(8.0), // Raio da borda
                          border: Border.all(
                            color: Colors.amber, // Cor da borda
                            width: 2.0, // Largura da borda
                          ),
                        ),
                        child: Text(
                          amount,
                          style: AppTextStyles.boldText(context,
                              size: 24, color: Colors.amber),
                        ),
                      ),
                      Text(
                        "Nível",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 16.0),
              TextFieldComponent(
                  label: "Nível",
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setState(() {
                      try {
                        var valNum = int.parse(val);
                        onAmountChanged(valNum);
                      } catch (e) {}
                    });
                  },
                  value: amount),
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
                    pressed: () => Navigator.pop(context, int.parse(amount)),
                    label: "Salvar",
                    tipo: 1,
                    icon: PhosphorIconsBold.floppyDisk,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
