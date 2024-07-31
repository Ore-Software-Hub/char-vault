import 'package:CharVault/components/details_component.dart';
import 'package:CharVault/components/header_component.dart';
import 'package:flutter/material.dart';

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
            const HeaderComponent(user: null),
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
                  const SizedBox(
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
