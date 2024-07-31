import 'package:CharVault/components/button_component.dart';
import 'package:CharVault/models/user_model.dart';
import 'package:CharVault/pages/create_character_page.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:CharVault/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _user = Provider.of<LoginProvider>(context, listen: false).userModel;
  }

  Widget userProfileCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[300], // Sem preenchimento
          borderRadius: BorderRadius.circular(8.0), // Raio da borda
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white, // Sem preenchimento
                borderRadius: BorderRadius.circular(50.0), // Raio da borda
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network("${_user?.image}",
                      width: 75.0,
                      height: 75.0,
                      fit: BoxFit.cover, errorBuilder: (BuildContext context,
                          Object exception, StackTrace? stackTrace) {
                    return const Text('😢');
                  })),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "${_user?.name}",
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget characterDetails(String name, String level) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey[300], // Sem preenchimento
          borderRadius: BorderRadius.circular(10.0), // Raio da borda
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('assets/img/char.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Nível $level"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget charactersList() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Meus personagens",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                characterDetails("Garry Floyd", "1"),
                characterDetails("Francis", "15"),
                characterDetails("Francis", "15"),
                characterDetails("Francis", "15"),
                characterDetails("Francis", "15"),
                characterDetails("Francis", "15"),
                characterDetails("Francis", "15"),
                characterDetails("Francis", "15"),
                characterDetails("Francis", "15"),
                characterDetails("Francis", "15"),
                characterDetails("Francis", "15"),
                characterDetails("Francis", "15"),
                characterDetails("Francis", "15"),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        actions: [
          ButtonComponent(
            pressed: () {
              AuthService.signOut();
              Navigator.pop(context);
            },
            icon: PhosphorIconsBold.signOut,
            tipo: 0,
          )
        ],
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            userProfileCard(),
            const SizedBox(height: 16),
            charactersList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CreateCharacterPage()),
          );
        },
        child: const PhosphorIcon(
          PhosphorIconsBold.plus,
        ),
      ),
    );
  }
}
