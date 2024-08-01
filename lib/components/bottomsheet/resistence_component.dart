import 'package:CharVault/components/skills_component.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:flutter/material.dart';

class ResistenceBottomSheetComponent extends StatefulWidget {
  const ResistenceBottomSheetComponent({super.key, required this.savingThrows});

  final List<FeatureDetails> savingThrows;

  @override
  _ResistenceBottomSheetComponentState createState() =>
      _ResistenceBottomSheetComponentState();
}

class _ResistenceBottomSheetComponentState
    extends State<ResistenceBottomSheetComponent> {
  double sheetHeight = 250;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 16),
      height: sheetHeight,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Teste de Resistência",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 4.0, // Espaçamento horizontal entre os widgets
            runSpacing: 4.0, // Espaçamento vertical entre as linhas
            children: widget.savingThrows.map<SkillsComponent>((feature) {
              return SkillsComponent(
                title: feature.title,
                value: feature.modifier.toString(),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
