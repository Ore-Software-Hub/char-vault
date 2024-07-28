import 'package:character_vault/pages/home/components/features_component.dart';
import 'package:character_vault/pages/home/components/skills_component.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "Garry Floyd",
      classe = "Bardo",
      level = "1",
      curLife = "15",
      maxLife = "17",
      pg = "15",
      pp = "15",
      pb = "15";

  @override
  void initState() {
    super.initState();
    // isUser = Provider.of<LoginProvider>(context, listen: false).userLogged;
    // if (isUser == null) {
    //   Navigator.pop(context);
    // }
    // loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              clipBehavior: Clip.none,
              children: [
                // Gradiente de fundo
                Container(
                  height: (MediaQuery.of(context).size.height / 2),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        Color.fromARGB(255, 155, 165, 149),
                        Color.fromARGB(255, 85, 87, 84),
                      ],
                      center: Alignment.center,
                      radius: 0.5,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        classe,
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.transparent, // Sem preenchimento
                                borderRadius: BorderRadius.circular(
                                    15.0), // Raio da borda
                                border: Border.all(
                                  color: Colors.amber, // Cor da borda
                                  width: 2.0, // Largura da borda
                                ),
                              ),
                              child: Text(
                                level,
                                style: const TextStyle(
                                  fontSize: 45,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            const Text(
                              "Nível",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const PhosphorIcon(
                            PhosphorIconsRegular.heart,
                            color: Colors.white,
                          ),
                          Text(
                            curLife,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            maxLife,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              children: [
                                const PhosphorIcon(PhosphorIconsRegular.coin,
                                    color: Colors.amber),
                                Text(
                                  pg,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              children: [
                                const PhosphorIcon(PhosphorIconsRegular.coin,
                                    color: Colors.white70),
                                Text(
                                  pp,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              children: [
                                const PhosphorIcon(PhosphorIconsRegular.coin,
                                    color: Color.fromARGB(255, 189, 86, 49)),
                                Text(
                                  pb,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                    right: 0,
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        "assets/img/char.png",
                      ),
                    )),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Row(
                    children: [
                      IconButton(
                        icon: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the radius as needed
                          child: Image.asset(
                            'assets/img/eu.jpg',
                            width: 50,
                          ),
                        ),
                        onPressed: () {
                          Scaffold.of(context)
                              .openDrawer(); // Abrir o Drawer ao clicar no ícone de menu
                        },
                      ),
                      const Text(
                        "João Pedro",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                ),
                // Imagem posicionada ao lado
              ],
            ),
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
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text("Teste de Resistência"))
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
            const Padding(
              padding: EdgeInsets.only(top: 24, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Habilidades",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 4.0, // Espaçamento horizontal entre os widgets
                    runSpacing: 4.0, // Espaçamento vertical entre as linhas
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
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
