import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/components/card.component.dart';
import 'package:CharVault/components/textfield.component.dart';
import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LifeBSComponent extends StatefulWidget {
  const LifeBSComponent(
      {super.key, required this.curLife, required this.maxLife});

  final int curLife;
  final int maxLife;

  @override
  State<LifeBSComponent> createState() => _LifeBSComponentState();
}

class _LifeBSComponentState extends State<LifeBSComponent> {
  int curLife = 0;
  int maxLife = 0;

  String curhp = "";
  String maxhp = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      curLife = widget.curLife;
      maxLife = widget.maxLife;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context)
            .viewInsets
            .bottom, // Ajusta altura para teclado
      ),
      child: SingleChildScrollView(
        // Permite rolagem se necessário
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Usa apenas o espaço necessário
            children: [
              Text(
                "Alterar Vida",
                style: AppTextStyles.boldText(context,
                    size: 20, color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardComponent(
                      top: Text(
                        "$curLife",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                        ),
                      ),
                      bottom: Text("HP")),
                  const SizedBox(width: 10),
                  CardComponent(
                      top: Text(
                        "$maxLife",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                        ),
                      ),
                      bottom: Text("Max HP")),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFieldComponent(
                  label: 'Vida atual',
                  onChanged: (val) {
                    setState(() {
                      curhp = val;
                      curLife = int.tryParse(val) ?? curLife;
                    });
                  },
                  value: curhp),
              const SizedBox(height: 5),
              TextFieldComponent(
                  label: 'Vida máxima',
                  onChanged: (val) {
                    setState(() {
                      maxhp = val;
                      maxLife = int.tryParse(val) ?? maxLife;
                    });
                  },
                  value: maxhp),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonComponent(
                    pressed: () => Navigator.pop(context),
                    label: "Cancelar",
                    tipo: 1,
                    icon: PhosphorIconsBold.x,
                  ),
                  const SizedBox(width: 10),
                  ButtonComponent(
                    pressed: () => Navigator.pop(context, [curLife, maxLife]),
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
