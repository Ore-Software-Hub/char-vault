import 'package:character_vault/pages/profile/components/details_component.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                  height: 350,
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
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        classe,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Column(
                          children: [
                            Container(
                              width: 30,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.transparent, // Sem preenchimento
                                borderRadius:
                                    BorderRadius.circular(8.0), // Raio da borda
                                border: Border.all(
                                  color: Colors.amber, // Cor da borda
                                  width: 2.0, // Largura da borda
                                ),
                              ),
                              child: Text(
                                level,
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            const Text(
                              "Nível",
                              style: TextStyle(
                                fontSize: 16,
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
                            size: 24,
                          ),
                          Text(
                            curLife,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            maxLife,
                            style: const TextStyle(
                              fontSize: 16,
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
                                    fontSize: 16,
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
                                    fontSize: 16,
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
                                    fontSize: 16,
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
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/img/char.png",
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
                          Scaffold.of(context)
                              .openDrawer(); // Abrir o Drawer ao clicar no ícone de menu
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
                    "Sobre",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      DetailsComponent(title: "Idade", value: "26 anos"),
                      DetailsComponent(title: "Raça", value: "Humano"),
                      DetailsComponent(title: "Antecedentes", value: "Artista"),
                      DetailsComponent(title: "Alinhamento", value: "Neutro"),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "História",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Sem preenchimento
                      borderRadius: BorderRadius.circular(8.0), // Raio da borda
                      border: Border.all(
                        color: Colors.black, // Cor da borda
                        width: 1.0, // Largura da borda
                      ),
                    ),
                    child: const Text(
                        "Garry é um músico que não tem talento para tocar alaúde, ele entrou na escola de música depois de ter se apaixonado na professora de música. Passou 1 ano na escola apenas flertando com a professora e não aprendendo nada. Seus pais pagaram 1 ano de aula e esperavam retorno, que nunca veio. Garry então mentiu para seus pais dizendo que ele teria uma turnê pelo mundo e precisava viajar por um tempo, mas era apenas uma desculpa esfarrapada para vadiar pelo mundo azarando as mulheres e torrando a heraça dele e de seus irmãos."),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
