import 'package:CharVault/components/item_component.dart';
import 'package:CharVault/pages/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BackPackPage extends StatefulWidget {
  const BackPackPage({super.key});

  @override
  State<BackPackPage> createState() => _BackPackPageState();
}

class _BackPackPageState extends State<BackPackPage> {
  String name = "Garry Floyd",
      classe = "Bardo",
      level = "1",
      curLife = "15/",
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
              alignment: AlignmentDirectional.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                // Gradiente de fundo
                Container(
                  height: (MediaQuery.of(context).size.height / 4),
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
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                classe,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      const PhosphorIcon(
                                        PhosphorIconsRegular.heart,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        curLife,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        maxLife,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w100,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Row(
                                          children: [
                                            const PhosphorIcon(
                                                PhosphorIconsRegular.coin,
                                                color: Colors.amber),
                                            Text(
                                              pg,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Row(
                                          children: [
                                            const PhosphorIcon(
                                                PhosphorIconsRegular.coin,
                                                color: Colors.white70),
                                            Text(
                                              pp,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Row(
                                          children: [
                                            const PhosphorIcon(
                                                PhosphorIconsRegular.coin,
                                                color: Color.fromARGB(
                                                    255, 189, 86, 49)),
                                            Text(
                                              pb,
                                              style: const TextStyle(
                                                fontSize: 20,
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
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 35,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.transparent, // Sem preenchimento
                                    borderRadius: BorderRadius.circular(
                                        8.0), // Raio da borda
                                    border: Border.all(
                                      color: Colors.amber, // Cor da borda
                                      width: 2.0, // Largura da borda
                                    ),
                                  ),
                                  child: Text(
                                    level,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.amber,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "Nível",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
                            width: 35,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UserProfilePage()));
                        },
                      ),
                      const Text(
                        "João Pedro",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                // Imagem posicionada ao lado
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Equipamentos",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 4.0, // Espaçamento horizontal entre os widgets
                    runSpacing: 4.0, // Espaçamento vertical entre as linhas
                    children: [
                      ItemComponent(
                          tipo: 0,
                          icon: PhosphorIconsRegular.shield,
                          title: "Elmo Élfico",
                          value: "+2 def"),
                      ItemComponent(
                          tipo: 0,
                          icon: PhosphorIconsRegular.shovel,
                          title: "Machado Lunar",
                          value: "1D4"),
                    ],
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Inventário",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 4.0, // Espaçamento horizontal entre os widgets
                    runSpacing: 4.0, // Espaçamento vertical entre as linhas
                    children: [
                      ItemComponent(
                          tipo: 1,
                          icon: PhosphorIconsRegular.champagne,
                          title: "Poção de cura",
                          value: "x10"),
                      ItemComponent(
                          tipo: 1,
                          icon: PhosphorIconsRegular.champagne,
                          title: "Poção de velocidade",
                          value: "x3"),
                      ItemComponent(
                          tipo: 1,
                          icon: PhosphorIconsRegular.dotsNine,
                          title: "Chave enferrujada",
                          value: null),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
