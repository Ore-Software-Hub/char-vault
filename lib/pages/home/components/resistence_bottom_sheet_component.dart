import 'package:character_vault/pages/home/components/skills_component.dart';
import 'package:flutter/material.dart';

class ResistenceBottomSheetComponent extends StatefulWidget {
  const ResistenceBottomSheetComponent({super.key});

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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Habilidades",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 4.0, // Espaçamento horizontal entre os widgets
            runSpacing: 4.0, // Espaçamento vertical entre as linhas
            children: [
              SkillsComponent(
                title: "Força",
                value: "8",
              ),
              SkillsComponent(
                title: "Destreza",
                value: "12",
              ),
              SkillsComponent(
                title: "Constituição",
                value: "10",
              ),
              SkillsComponent(
                title: "Inteligência",
                value: "14",
              ),
              SkillsComponent(
                title: "Sabedoria",
                value: "13",
              ),
              SkillsComponent(
                title: "Carisma",
                value: "15",
              )
            ],
          )
        ],
      ),
    );
  }
}
