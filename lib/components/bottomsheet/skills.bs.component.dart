import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/components/line.component.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter/material.dart';

class SkillsBSComponent extends StatefulWidget {
  const SkillsBSComponent({
    super.key,
    required this.features,
  });

  final List<FeatureDetails> features;

  @override
  State<SkillsBSComponent> createState() => _SkillsBSComponentState();
}

class _SkillsBSComponentState extends State<SkillsBSComponent> {
  String actual = '';
  List<FeatureDetails> features = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      features = widget.features;
    });
  }

  filterSkills(String feature) {
    setState(() {
      actual = feature;
    });

    List<FeatureDetails> filtered = [];

    if (feature != '') {
      for (var feat in widget.features) {
        if (feat.title == feature) {
          filtered.add(feat);
          break;
        }
      }
    } else {
      filtered = widget.features;
    }

    setState(() {
      features = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<SkillDetails> skills = [];
    for (var feat in features) {
      if (feat.skills == null) continue;
      for (var skill in feat.skills!) {
        skills.add(skill);
      }
    }
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Perícias",
              style: AppTextStyles.boldText(context,
                  size: 24, color: Theme.of(context).colorScheme.onSurface),
            ),
            const Divider(
              indent: 150,
              endIndent: 150,
            ),
            if (skills.isEmpty) Text("Nenhuma perícia encontrada"),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              spacing: 4.0, // Espaçamento horizontal entre os widgets
              runSpacing: 8.0, // Espaçamento vertical entre as linhas
              children: skills.map<LineComponent>((skill) {
                return LineComponent(
                  title: skill.title,
                  value: skill.value.toString(),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              spacing: 4.0, // Espaçamento horizontal entre os widgets
              runSpacing: 8.0,
              children: [
                ButtonComponent(
                  pressed: () => filterSkills('Força'),
                  label: 'For',
                ),
                ButtonComponent(
                  pressed: () => filterSkills('Destreza'),
                  label: 'Des',
                ),
                ButtonComponent(
                  pressed: () => filterSkills('Constituição'),
                  label: 'Con',
                ),
                ButtonComponent(
                  pressed: () => filterSkills('Inteligência'),
                  label: 'Int',
                ),
                ButtonComponent(
                  pressed: () => filterSkills('Sabedoria'),
                  label: 'Sab',
                ),
                ButtonComponent(
                  pressed: () => filterSkills('Carisma'),
                  label: 'Car',
                ),
                ButtonComponent(
                  pressed: () => filterSkills(''),
                  label: 'Todos',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
