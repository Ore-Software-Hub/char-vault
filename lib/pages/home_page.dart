import 'package:CharVault/components/bottomsheet/edit_life_component%20copy.dart';
import 'package:CharVault/components2/card.component.dart';
import 'package:CharVault/components2/features.component.dart';
import 'package:CharVault/components/bottomsheet/skills.component.dart';
import 'package:CharVault/components2/header.component.dart';
import 'package:CharVault/components/skills_component.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:CharVault/services/database_service.dart';
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
          padding: const EdgeInsets.all(16),
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
          padding: const EdgeInsets.all(16),
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
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Outras Informações",
                    style: AppTextStyles.boldText(context, size: 20),
                  ),
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                spacing: 4.0, // Espaçamento horizontal entre os widgets
                runSpacing: 8.0, // Espaçamento vertical entre as linhas
                children: [
                  CardComponent(
                      top: InkWell(
                        onTap: () async {
                          final newLifeVal = await showModalBottomSheet<String>(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            showDragHandle: true,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => EditLifeBottomSheetComponent(
                              curLife: _char!.curLife,
                              maxLife: _char!.maxLife,
                            ),
                          );

                          if (newLifeVal != null) {
                            setState(() {
                              _char!.curLife = newLifeVal;
                              Provider.of<LoginProvider>(context, listen: false)
                                  .updateUser(char: _char);
                            });
                            await DatabaseService.updateCharacter(
                                _char!.id, _char!.toMap());
                          }
                        },
                        child: Text(
                          "${_char!.curLife}/${_char!.maxLife}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      bottom: Text(
                        "PV Atual",
                        style: AppTextStyles.lightText(context, size: 12),
                        overflow: TextOverflow.ellipsis,
                      )),
                  CardComponent(
                      top: Text(
                        "1d8",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                        ),
                      ),
                      bottom: Text(
                        "Dado PV",
                        style: AppTextStyles.lightText(context, size: 12),
                        overflow: TextOverflow.ellipsis,
                      )),
                  CardComponent(
                      top: Text(
                        "+2",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                        ),
                      ),
                      bottom: Text(
                        "Proficiência",
                        style: AppTextStyles.lightText(context, size: 12),
                        overflow: TextOverflow.ellipsis,
                      )),
                  CardComponent(
                      top: Text(
                        "+1",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                        ),
                      ),
                      bottom: Text(
                        "Inspiração",
                        style: AppTextStyles.lightText(context, size: 12),
                        overflow: TextOverflow.ellipsis,
                      )),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
