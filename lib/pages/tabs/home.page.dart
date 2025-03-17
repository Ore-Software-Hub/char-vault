import 'package:CharVault/components/bottomsheet/card.bs.component.dart';
import 'package:CharVault/components/bottomsheet/life.bs.component.dart';
import 'package:CharVault/components/bottomsheet/skills.bs.component.dart';
import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/components/card.component.dart';
import 'package:CharVault/components/features.component.dart';
import 'package:CharVault/components/header.component.dart';
import 'package:CharVault/components/line.component.dart';
import 'package:CharVault/constants/strings.constants.dart';
import 'package:CharVault/helpers/shared_preferences.helper.dart';
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
  int inspiration = 0;

  @override
  void initState() {
    super.initState();
    _char = Provider.of<LoginProvider>(context, listen: false).userModel!.char;
    loadData();
  }

  loadData() async {
    var data =
        await SharedPreferencesHelper.getData('int', Constants.inspiration);
    setState(() {
      inspiration = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<SkillDetails> skills = [];
    for (var feat in _char!.features) {
      if (feat.skills == null) continue;
      for (var skill in feat.skills!) {
        skills.add(skill);
      }
    }
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
                    style: AppTextStyles.boldText(context,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 4.0, // Espaçamento horizontal entre os widgets
                runSpacing: 4.0, // Espaçamento vertical entre as linhas
                children: _char!.features.map<FeaturesComponent>((feature) {
                  return FeaturesComponent(
                    feature: feature,
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
                    "Perícias",
                    style: AppTextStyles.boldText(context,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  ButtonComponent(
                      tipo: 2,
                      pressed: () {
                        showModalBottomSheet(
                            context: context,
                            useSafeArea: true,
                            isScrollControlled: true,
                            showDragHandle: true,
                            builder: (context) =>
                                SkillsBSComponent(features: _char!.features));
                      },
                      label: "Ver Todos")
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                spacing: 4.0, // Espaçamento horizontal entre os widgets
                runSpacing: 8.0, // Espaçamento vertical entre as linhas
                children: skills.take(8).map<LineComponent>((skill) {
                  return LineComponent(
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
                    style: AppTextStyles.boldText(context,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurface),
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
                          final newLife = await showModalBottomSheet<List<int>>(
                            showDragHandle: true,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => LifeBSComponent(
                              curLife: _char!.details.curLife,
                              maxLife: _char!.details.maxLife,
                            ),
                          );

                          if (newLife != null) {
                            setState(() {
                              _char!.details.curLife = newLife[0];
                              _char!.details.maxLife = newLife[1];
                              Provider.of<LoginProvider>(context, listen: false)
                                  .updateUser(char: _char);
                            });
                            await DatabaseService.updateCharacter(
                                _char!.id, _char!.toMap());
                          }
                        },
                        child: Text(
                          "${_char!.details.curLife}/${_char!.details.maxLife}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      bottom: Text(
                        "PV Atual",
                        style: AppTextStyles.lightText(context,
                            size: 12,
                            color: Theme.of(context).colorScheme.onSurface),
                        overflow: TextOverflow.ellipsis,
                      )),
                  CardComponent(
                      top: Text(
                        "1d${_char!.details.classModel.hp}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                        ),
                      ),
                      bottom: Text(
                        "Dado PV",
                        style: AppTextStyles.lightText(context,
                            size: 12,
                            color: Theme.of(context).colorScheme.onSurface),
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
                        style: AppTextStyles.lightText(context,
                            size: 12,
                            color: Theme.of(context).colorScheme.onSurface),
                        overflow: TextOverflow.ellipsis,
                      )),
                  CardComponent(
                      top: InkWell(
                        onTap: () async {
                          final newAmount = await showModalBottomSheet<int>(
                            showDragHandle: true,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => CardBSComponent(
                              amount: inspiration,
                              title: "Inspiração",
                            ),
                          );

                          if (newAmount != null) {
                            setState(() {
                              inspiration = newAmount;
                              SharedPreferencesHelper.setData(
                                  'int', Constants.inspiration, inspiration);
                            });
                          }
                        },
                        child: Text(
                          inspiration <= 0 ? '0' : '+$inspiration',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      bottom: Text(
                        "Inspiração",
                        style: AppTextStyles.lightText(context,
                            size: 12,
                            color: Theme.of(context).colorScheme.onSurface),
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
