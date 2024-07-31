import 'package:CharVault/components/features_component.dart';
import 'package:CharVault/components/bottomsheet/resistence_component.dart';
import 'package:CharVault/components/header_component.dart';
import 'package:CharVault/components/skills_component.dart';
import 'package:CharVault/models/user_model.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _user = Provider.of<LoginProvider>(context, listen: false).userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderComponent(),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Características",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) =>
                                    const ResistenceBottomSheetComponent());
                          },
                          child: Text("Teste de Resistência",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300)))
                    ],
                  ),
                  const Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 4.0, // Espaçamento horizontal entre os widgets
                    runSpacing: 4.0, // Espaçamento vertical entre as linhas
                    children: [
                      FeaturesComponent(
                          title: "Força", value: "8", modifier: "-1"),
                      FeaturesComponent(
                          title: "Destreza", value: "12", modifier: "+1"),
                      FeaturesComponent(
                          title: "Constituição", value: "10", modifier: "+1"),
                      FeaturesComponent(
                          title: "Inteligência", value: "14", modifier: "+1"),
                      FeaturesComponent(
                          title: "Sabedoria", value: "13", modifier: "+1"),
                      FeaturesComponent(
                          title: "Carisma", value: "15", modifier: "+1"),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                padding: EdgeInsets.only(top: 24, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Habilidades",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      spacing: 4.0, // Espaçamento horizontal entre os widgets
                      runSpacing: 8.0, // Espaçamento vertical entre as linhas
                      children: [
                        SkillsComponent(title: "Acrobacia", value: "+2"),
                        SkillsComponent(title: "Arcanismo", value: "+2"),
                        SkillsComponent(title: "Atletismo", value: "-1"),
                        SkillsComponent(title: "Atuação", value: "+2"),
                        SkillsComponent(title: "Enganação", value: "+3"),
                        SkillsComponent(title: "Furtividade", value: "0"),
                        SkillsComponent(title: "História", value: "+2"),
                        SkillsComponent(title: "Intimidação", value: "0"),
                        SkillsComponent(title: "Intuição", value: "0"),
                        SkillsComponent(title: "Investigação", value: "+2"),
                        SkillsComponent(title: "Lidar com Animais", value: "0"),
                        SkillsComponent(title: "Medicina", value: "-1"),
                        SkillsComponent(title: "Natureza", value: "+2"),
                        SkillsComponent(title: "Percepção", value: "0"),
                        SkillsComponent(title: "Persuação", value: "+2"),
                        SkillsComponent(title: "Prestidigitação", value: "0"),
                        SkillsComponent(title: "Religião", value: "0"),
                        SkillsComponent(title: "Sobrevivência", value: "-1"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
