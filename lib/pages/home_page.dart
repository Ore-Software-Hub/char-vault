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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "João Pedro",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: PhosphorIcon(
              PhosphorIconsRegular.gear,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              // Abrir configurações
            },
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: ClipRRect(
                borderRadius:
                    BorderRadius.circular(100.0), // Adjust the radius as needed
                child: Image.asset('assets/img/eu.jpg'),
              ),
              onPressed: () {
                Scaffold.of(context)
                    .openDrawer(); // Abrir o Drawer ao clicar no ícone de menu
              },
            );
          },
        ),
      ),
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
                  height: (MediaQuery.of(context).size.height / 2) + 50,
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
                // Imagem posicionada ao lado

                Positioned(
                  right: 0,
                  child: Image.asset(
                    "assets/img/char.png",
                    height: 450,
                    width: 350,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
