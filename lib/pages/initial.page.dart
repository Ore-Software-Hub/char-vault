import 'dart:async';

import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/pages/dice.page.dart';
import 'package:CharVault/pages/tabs/backpack.page.dart';
import 'package:CharVault/pages/tabs/fight.page.dart';
import 'package:CharVault/pages/tabs/home.page.dart';
import 'package:CharVault/pages/tabs/magic.page.dart';
import 'package:CharVault/pages/tabs/papers.page.dart';
import 'package:CharVault/pages/tabs/profile.page.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  int _selectedIndex = 0;
  bool loading = true;
  CharacterModel? char;

  List<Widget> tabs = [
    const HomePage(),
    const ProfilePage(),
    const FightPage(),
    const BackPackPage(),
    // TODO: Adicionar as outras tabs aqui
    const MagicPage(),
    const PapersPage(),
  ];

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
            char = Provider.of<LoginProvider>(context, listen: false)
                .userModel!
                .char;
          });
        } else {
          setState(() {
            duration--;
          });
        }
      },
    );
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                  color: Theme.of(context).colorScheme.primary, size: 40),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SafeArea(child: tabs[_selectedIndex]),
                ],
              ),
            ),
      floatingActionButton: SpeedDial(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        overlayColor: Theme.of(context).colorScheme.secondary,
        animatedIcon: AnimatedIcons.menu_arrow,
        children: [
          SpeedDialChild(
            child: const PhosphorIcon(
              PhosphorIconsBold.diceFive,
            ),
            label: 'Rolar dados',
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DicePage()));
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        color: Theme.of(context).colorScheme.primary,
        child: GNav(
          backgroundColor: Theme.of(context).colorScheme.primary,
          color: Theme.of(context).colorScheme.onPrimary,
          activeColor: Theme.of(context).colorScheme.primary,
          selectedIndex: _selectedIndex,
          onTabChange: _onItemTapped,
          gap: 8,
          tabBackgroundColor: Theme.of(context).colorScheme.onPrimary,
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          tabs: [
            GButton(
              icon: PhosphorIconsThin.house,
              text: 'Início',
            ),
            GButton(
              icon: PhosphorIconsThin.user,
              text: 'Personagem',
            ),
            GButton(
              icon: PhosphorIconsThin.sword,
              text: 'Combate',
            ),
            GButton(
              icon: PhosphorIconsThin.backpack,
              text: 'Inventário',
            ),
            GButton(
              icon: PhosphorIconsThin.scroll,
              text: 'Magias',
            ),
            GButton(
              icon: PhosphorIconsThin.note,
              text: 'Documentos',
            ),
          ],
        ),
      ),
    );
  }
}
