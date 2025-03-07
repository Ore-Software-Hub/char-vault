import 'package:CharVault/components/features_component.dart';
import 'package:CharVault/components/bottomsheet/skills.component.dart';
import 'package:CharVault/components/header_component.dart';
import 'package:CharVault/components/skills_component.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CharacterModel? _char;

  @override
  void initState() {
    super.initState();
    _char = Provider.of<LoginProvider>(context, listen: false).userModel!.char;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderComponent(
          type: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Características",
                    style: AppTextStyles.boldText(context, size: 20),
                  ),
                ],
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 4.0, // Espaçamento horizontal entre os widgets
                runSpacing: 4.0, // Espaçamento vertical entre as linhas
                children: _char!.features!.map<FeaturesComponent>((feature) {
                  return FeaturesComponent(
                    title: feature.title,
                    value: feature.value.toString(),
                    modifier: feature.modifier.toString(),
                    test: feature.modifier.toString(),
                  );
                }).toList(),
              )
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Habilidades",
                    style: AppTextStyles.boldText(context, size: 20),
                  ),
                  TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            useSafeArea: true,
                            isScrollControlled: true,
                            showDragHandle: true,
                            builder: (context) => SkillsBottomSheetComponent(
                                skills: _char!.skills!));
                      },
                      child: Text("Ver Todos",
                          style: AppTextStyles.lightText(context, size: 14)))
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                spacing: 4.0, // Espaçamento horizontal entre os widgets
                runSpacing: 8.0, // Espaçamento vertical entre as linhas
                children: _char!.skills!.take(8).map<SkillsComponent>((skill) {
                  return SkillsComponent(
                    title: skill.title,
                    value: skill.value.toString(),
                  );
                }).toList(),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
