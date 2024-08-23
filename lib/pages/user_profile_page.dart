import 'dart:async';

import 'package:CharVault/components/button_component.dart';
import 'package:CharVault/components/char_details_component.dart';
import 'package:CharVault/helpers/notification_helper.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/user_model.dart';
import 'package:CharVault/pages/create_character_page.dart';
import 'package:CharVault/pages/landing_page.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:CharVault/services/auth_service.dart';
import 'package:CharVault/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserModel? _user;
  bool loading = true;
  bool loadingChars = false;

  List<CharacterModel> chars = [];

  @override
  void initState() {
    super.initState();
    int duration = 1;
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (duration == 0) {
          setState(() {
            timer.cancel();
            loading = false;
            Provider.of<LoginProvider>(context, listen: false).updateUser();
            _user =
                Provider.of<LoginProvider>(context, listen: false).userModel;
            loadChars();
          });
        } else {
          setState(() {
            duration--;
          });
        }
      },
    );
  }

  loadChars() async {
    setState(() {
      loadingChars = true;
    });
    try {
      var charsLoaded = await DatabaseService.getUserCharacters();
      setState(() {
        chars = charsLoaded!;
        loadingChars = false;
      });
    } catch (e) {
      NotificationHelper.showSnackBar(context, e.toString(), level: 2);
      setState(() {
        loadingChars = false;
      });
    }
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${_user?.name}",
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "v0.2.0-beta",
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
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

  Widget charactersList() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Meus personagens",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ButtonComponent(
                  pressed: () {
                    _pullRefresh();
                  },
                  tipo: 0,
                  icon: PhosphorIconsBold.arrowsClockwise,
                )
              ],
            ),
            loadingChars
                ? Center(
                    child: LoadingAnimationWidget.twistingDots(
                        leftDotColor: Theme.of(context).colorScheme.primary,
                        rightDotColor: Theme.of(context).colorScheme.secondary,
                        size: 30),
                  )
                : chars.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey[300], // Sem preenchimento
                              borderRadius:
                                  BorderRadius.circular(10.0), // Raio da borda
                            ),
                            child: const Row(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: PhosphorIcon(
                                      PhosphorIconsBold.placeholder),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Nenhum personagem encontrado",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("Crie um novo!"),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: chars.map<CharDetailsComponent>((char) {
                          return CharDetailsComponent(char: char);
                        }).toList(),
                      )
          ],
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    await loadChars();
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
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LandingPage()),
                (route) => false,
              );
            },
            icon: PhosphorIconsBold.signOut,
            tipo: 0,
          )
        ],
        forceMaterialTransparency: true,
      ),
      body: loading
          ? Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                  color: Theme.of(context).colorScheme.primary, size: 40),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  userProfileCard(),
                  const SizedBox(height: 16),
                  charactersList(),
                ],
              ),
            ),
      floatingActionButton: loading
          ? null
          : FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateCharacterPage()),
                );
                loadChars();
              },
              child: const PhosphorIcon(
                PhosphorIconsBold.plus,
              ),
            ),
    );
  }
}
