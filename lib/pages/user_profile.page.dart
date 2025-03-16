import 'dart:async';

import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/components/char_details.component.dart';
import 'package:CharVault/helpers/notification.helper.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/user_model.dart';
import 'package:CharVault/pages/create_character.page.dart';
import 'package:CharVault/pages/landing.page.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:CharVault/providers/theme_provider.dart';
import 'package:CharVault/services/auth_service.dart';
import 'package:CharVault/services/database_service.dart';
import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserModel? _user;
  bool loading = true;
  bool loadingChars = false;
  String appVersion = '';

  List<CharacterModel> chars = [];

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform()
        .then((PackageInfo info) => {appVersion = info.version});
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
        height: MediaQuery.of(context).size.width / 4,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(20),
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(2, 4),
            )
          ],
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          spacing: 10,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.width / 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(8),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network("${_user?.image}", fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                      return LoadingAnimationWidget.beat(
                          color: Colors.black, size: 40);
                    })),
              ),
            ),
            Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _user!.name,
                  style: AppTextStyles.boldText(context,
                      color: Theme.of(context).colorScheme.secondary, size: 20),
                ),
                Text(_user!.email,
                    style: AppTextStyles.lightText(context,
                        size: 14,
                        color: Theme.of(context).colorScheme.onSurface)),
                Text(
                  'v$appVersion',
                  style: AppTextStyles.italicText(context,
                      size: 14, color: Theme.of(context).colorScheme.onSurface),
                ),
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
                  tipo: 3,
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
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withAlpha(20),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                  offset: Offset(2, 4),
                                )
                              ],
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(8.0),
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
                          return CharDetailsComponent(
                              char: char,
                              updated: () {
                                _pullRefresh();
                              });
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
            pressed:
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme,
            icon: Provider.of<ThemeProvider>(context, listen: false)
                        .themeData
                        .brightness ==
                    Brightness.light
                ? PhosphorIconsThin.moonStars
                : PhosphorIconsThin.sun,
            tipo: 3,
          ),
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
            tipo: 3,
          ),
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
