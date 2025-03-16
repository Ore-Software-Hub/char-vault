import 'dart:async';

import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/pages/tabs/backpack.page.dart';
import 'package:CharVault/pages/tabs/fight.page.dart';
import 'package:CharVault/pages/tabs/home.page.dart';
import 'package:CharVault/pages/tabs/magic.page.dart';
import 'package:CharVault/pages/tabs/papers.page.dart';
import 'package:CharVault/pages/tabs/profile.page.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
              // showModalBottomSheet(
              //   backgroundColor: Theme.of(context).colorScheme.secondary,
              //   showDragHandle: true,
              //   context: context,
              //   isScrollControlled: true,
              //   builder: (context) => const DiceBottomSheetComponent(),
              // );
            },
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        animationDuration: const Duration(milliseconds: 200),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        color: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
        items: [
          PhosphorIcon(
            color: Theme.of(context).colorScheme.onPrimary,
            PhosphorIconsThin.house,
          ),
          PhosphorIcon(
            color: Theme.of(context).colorScheme.onPrimary,
            PhosphorIconsThin.user,
          ),
          PhosphorIcon(
            color: Theme.of(context).colorScheme.onPrimary,
            PhosphorIconsThin.sword,
          ),
          PhosphorIcon(
            color: Theme.of(context).colorScheme.onPrimary,
            PhosphorIconsThin.backpack,
          ),
          PhosphorIcon(
            color: Theme.of(context).colorScheme.onPrimary,
            PhosphorIconsThin.scroll,
          ),
          PhosphorIcon(
            color: Theme.of(context).colorScheme.onPrimary,
            PhosphorIconsThin.note,
          ),
        ],
      ),
    );
  }
}
