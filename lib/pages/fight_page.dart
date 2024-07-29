import 'package:character_vault/components/bottomsheet/add_item_component.dart';
import 'package:character_vault/components/button_component.dart';
import 'package:character_vault/components/item_component.dart';
import 'package:character_vault/pages/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:character_vault/constants/cores.constants.dart' as cores;

class FightPage extends StatefulWidget {
  const FightPage({super.key});

  @override
  State<FightPage> createState() => _FightPageState();
}

class _FightPageState extends State<FightPage> {
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
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Armas",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ButtonComponent(
                          tipo: 0,
                          pressed: () {
                            showModalBottomSheet(
                              backgroundColor: cores.secondaryColor,
                              showDragHandle: true,
                              context: context,
                              isScrollControlled: true,
                              builder: (context) =>
                                  const AddItemBottomSheetComponent(
                                tipo: 2,
                                editing: false,
                              ),
                            );
                          },
                          icon: PhosphorIconsBold.plus)
                    ],
                  ),
                  const Column(
                    children: [
                      ItemComponent(
                          tipo: 2,
                          icon: PhosphorIconsRegular.sword,
                          title: "Espada larga",
                          value: "1D6"),
                      ItemComponent(
                          tipo: 2,
                          icon: PhosphorIconsRegular.sword,
                          title: "Besta leve",
                          value: "1D4"),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Magias",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ButtonComponent(
                          tipo: 0,
                          pressed: () {
                            showModalBottomSheet(
                              backgroundColor: cores.secondaryColor,
                              showDragHandle: true,
                              context: context,
                              isScrollControlled: true,
                              builder: (context) =>
                                  const AddItemBottomSheetComponent(
                                tipo: 3,
                                editing: false,
                              ),
                            );
                          },
                          icon: PhosphorIconsBold.plus)
                    ],
                  ),
                  const Column(
                    children: [
                      ItemComponent(
                          tipo: 3,
                          icon: PhosphorIconsRegular.lightning,
                          title: "Canto sombrio",
                          value: "1D4"),
                      ItemComponent(
                          tipo: 3,
                          icon: PhosphorIconsRegular.lightning,
                          title: "Canto amoroso",
                          value: "2 turnos"),
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
