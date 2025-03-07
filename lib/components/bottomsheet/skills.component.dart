import 'package:CharVault/components/skills_component.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:flutter/material.dart';

class SkillsBottomSheetComponent extends StatefulWidget {
  const SkillsBottomSheetComponent({super.key, required this.skills});

  final List<SkillDetails> skills;

  @override
  _SkillsBottomSheetComponentState createState() =>
      _SkillsBottomSheetComponentState();
}

class _SkillsBottomSheetComponentState
    extends State<SkillsBottomSheetComponent> {
  double sheetHeight = 350;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // padding: const EdgeInsets.only(top: 16),
      height: sheetHeight,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Todas as Habilidades",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 4.0, // Espaçamento horizontal entre os widgets
              runSpacing: 4.0, // Espaçamento vertical entre as linhas
              children: widget.skills.map<SkillsComponent>((feature) {
                return SkillsComponent(
                  title: feature.title,
                  value: feature.value.toString(),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
