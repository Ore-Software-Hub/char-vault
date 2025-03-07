import 'dart:async';

import 'package:CharVault/components/bottomsheet/add_item_component.dart';
import 'package:CharVault/components/header_component.dart';
import 'package:CharVault/helpers/notification_helper.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:CharVault/pages/backpack_page.dart';
import 'package:CharVault/components/bottomsheet/dice_component.dart';
import 'package:CharVault/components/bottomsheet/notes_component.dart';
import 'package:CharVault/pages/fight_page.dart';
import 'package:CharVault/pages/home_page.dart';
import 'package:CharVault/pages/profile_page.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:CharVault/services/database_service.dart';
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
  CharacterModel? _char;

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
    int duration = 1;
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (duration == 0) {
          setState(() {
            timer.cancel();
            loading = false;
            _char = Provider.of<LoginProvider>(context, listen: false)
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
                  const HeaderComponent(),
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
              showModalBottomSheet(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                showDragHandle: true,
                context: context,
                isScrollControlled: true,
                builder: (context) => const DiceBottomSheetComponent(),
              );
            },
          ),
          if (_selectedIndex == 1 || _selectedIndex == 2)
            SpeedDialChild(
                child: const PhosphorIcon(
                  PhosphorIconsBold.plus,
                ),
                label: 'Adicionar item',
                onTap: () async {
                  final item = await showModalBottomSheet<ItemModel>(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    showDragHandle: true,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const AddItemBottomSheetComponent(
                      editing: false,
                    ),
                  );
                  if (item != null) {
                    final itemId =
                        await DatabaseService.addItem(_char!.id, item);
                    NotificationHelper.showSnackBar(context,
                        "Item ${itemId != null ? "Adicionado" : "Não adicionado"}",
                        level: itemId != null ? 1 : 0);
                  }
                }),
          SpeedDialChild(
            child: const PhosphorIcon(
              PhosphorIconsBold.note,
            ),
            label: 'Anotações',
            onTap: () async {
              final note = await showModalBottomSheet<String?>(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                showDragHandle: true,
                context: context,
                isScrollControlled: true,
                builder: (context) => NotesBottomSheetComponent(
                  note: _char!.notes,
                ),
              );

              if (note != null) {
                setState(() {
                  _char!.notes = note;
                });
                await DatabaseService.updateCharacter(
                    _char!.id, _char!.toMap());
                NotificationHelper.showSnackBar(context, "Notas atualizadas");
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        animationDuration: const Duration(milliseconds: 200),
        backgroundColor: Colors.white,
        color: Theme.of(context).colorScheme.secondary,
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
