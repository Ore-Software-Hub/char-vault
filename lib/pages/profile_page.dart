import 'package:CharVault/components/details_component.dart';
import 'package:CharVault/components/header_component.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  CharacterModel? _char;

  @override
  void initState() {
    super.initState();
    _char = Provider.of<LoginProvider>(context, listen: false).userModel!.char;
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
              padding:
                  const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sobre",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      DetailsComponent(
                          title: "Idade", value: _char!.details!.age),
                      DetailsComponent(
                          title: "Raça", value: _char!.details!.race),
                      DetailsComponent(
                          title: "Antecedentes",
                          value: _char!.details!.background),
                      DetailsComponent(
                          title: "Alinhamento",
                          value: _char!.details!.alignment),
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
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Sem preenchimento
                      borderRadius: BorderRadius.circular(8.0), // Raio da borda
                      border: Border.all(
                        color: Colors.black, // Cor da borda
                        width: 1.0, // Largura da borda
                      ),
                    ),
                    child: Text(_char!.details!.backstory),
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
