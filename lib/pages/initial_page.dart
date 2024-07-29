import 'package:character_vault/pages/backpack_page.dart';
import 'package:character_vault/components/bottomsheet/dice_component.dart';
import 'package:character_vault/components/bottomsheet/notes_component.dart';
import 'package:character_vault/pages/fight_page.dart';
import 'package:character_vault/pages/home_page.dart';
import 'package:character_vault/pages/profile_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:character_vault/constants/cores.constants.dart' as cores;

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  int _selectedIndex = 0;

  List<Widget> tabs = [
    const HomePage(),
    const BackPackPage(),
    const FightPage(),
    const ProfilePage()
  ];
  List<String> tabsNames = ["Início", "Inventário", "Combate", "Perfil"];

  @override
  void initState() {
    super.initState();
    // isUser = Provider.of<LoginProvider>(context, listen: false).userLogged;
    // if (isUser == null) {
    //   Navigator.pop(context);
    // }
    // loadUser();
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(child: tabs[_selectedIndex]),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_arrow,
        children: [
          SpeedDialChild(
            child: const PhosphorIcon(
              PhosphorIconsBold.diceFive,
            ),
            label: 'Rolar dados',
            onTap: () {
              showModalBottomSheet(
                backgroundColor: cores.secondaryColor,
                showDragHandle: true,
                context: context,
                isScrollControlled: true,
                builder: (context) => const DiceBottomSheetComponent(),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.comment),
            label: 'Anotações',
            onTap: () {
              showModalBottomSheet(
                backgroundColor: cores.secondaryColor,
                showDragHandle: true,
                context: context,
                isScrollControlled: true,
                builder: (context) => const NotesBottomSheetComponent(),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        animationDuration: const Duration(milliseconds: 200),
        backgroundColor: Colors.white,
        color: cores.secondaryColor,
        onTap: _onItemTapped,
        items: const [
          PhosphorIcon(
            color: Colors.white,
            PhosphorIconsThin.house,
          ),
          PhosphorIcon(
            color: Colors.white,
            PhosphorIconsThin.backpack,
          ),
          PhosphorIcon(
            color: Colors.white,
            PhosphorIconsThin.handFist,
          ),
          PhosphorIcon(
            color: Colors.white,
            PhosphorIconsThin.user,
          ),
        ],
      ),
    );
  }
}
