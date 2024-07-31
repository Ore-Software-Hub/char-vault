import 'package:CharVault/components/skills_component.dart';
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
            children: [
              SkillsComponent(
                title: "Força",
                value: "0",
              ),
              SkillsComponent(
                title: "Destreza",
                value: "+1",
              ),
              SkillsComponent(
                title: "Constituição",
                value: "+1",
              ),
              SkillsComponent(
                title: "Inteligência",
                value: "+2",
              ),
              SkillsComponent(
                title: "Sabedoria",
                value: "+4",
              ),
              SkillsComponent(
                title: "Carisma",
                value: "+4",
              )
            ],
          )
        ],
      ),
    );
  }
}
