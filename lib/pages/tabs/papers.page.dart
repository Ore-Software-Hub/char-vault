import 'package:CharVault/components/bottomsheet/papers.bs.component.dart';
import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/components/header.component.dart';
import 'package:CharVault/components/section.component.dart';
import 'package:CharVault/helpers/notification.helper.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/paper.model.dart';
import 'package:CharVault/pages/add_paper.page.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:CharVault/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class PapersPage extends StatefulWidget {
  const PapersPage({super.key});

  @override
  State<PapersPage> createState() => _PapersPageState();
}

class _PapersPageState extends State<PapersPage> {
  List<PapersModel> _missions = [], _relationships = [], _notes = [];
  CharacterModel? _char;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _char = Provider.of<LoginProvider>(context, listen: false).userModel!.char;
    loadItems();
  }

  loadItems() async {
    var charPapers = await DatabaseService.getCharPapers(_char!.id);

    List<PapersModel> notes = [], missions = [], relationships = [];

    for (var paper in charPapers) {
      if (paper.tipo == 'note') {
        notes.add(paper);
      } else if (paper.tipo == 'mission') {
        missions.add(paper);
      } else if (paper.tipo == 'relationship') {
        relationships.add(paper);
      }
    }

    if (mounted) {
      setState(() {
        _missions = missions;
        _notes = notes;
        _relationships = relationships;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderComponent(
          type: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SectionComponent(
              title: 'Missões',
              list: _missions,
              selectedItem: (index) {
                showModalBottomSheet(
                  context: context,
                  useSafeArea: true,
                  isScrollControlled: true,
                  showDragHandle: false,
                  barrierColor: Color.fromARGB(255, 229, 201, 144),
                  builder: (context) =>
                      PapersBSComponent(paper: _missions[index]),
                );
              },
              removeItem: (index) async {
                await DatabaseService.deletePaper(
                    _char!.id, _missions[index].id);
                setState(() {
                  _missions.removeAt(index);
                });
                Provider.of<LoginProvider>(context, listen: false)
                    .updateUser(char: _char);
              },
              buttonAdd: ButtonComponent(
                pressed: () async {
                  List<String>? resultado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPaperPage(
                        title: "Missão",
                        body: true,
                      ),
                    ),
                  );

                  String? itemId;

                  if (resultado != null) {
                    var paper = PapersModel(
                        id: '',
                        title: resultado[0],
                        description: resultado[1],
                        tipo: 'mission');
                    try {
                      itemId = await DatabaseService.addPaper(_char!.id, paper);
                      _missions.add(paper);
                    } catch (e) {
                      NotificationHelper.showSnackBar(context,
                          "Missão ${itemId != null ? "Adicionada" : "Não adicionada"}",
                          level: itemId != null ? 1 : 0);
                    }
                  }
                },
                tipo: 3,
                icon: PhosphorIconsBold.plus,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SectionComponent(
              title: "NPC's & Relacionamentos",
              list: _relationships,
              selectedItem: (index) {
                showModalBottomSheet(
                  context: context,
                  useSafeArea: true,
                  isScrollControlled: true,
                  showDragHandle: false,
                  barrierColor: Color.fromARGB(255, 229, 201, 144),
                  builder: (context) =>
                      PapersBSComponent(paper: _relationships[index]),
                );
              },
              removeItem: (index) async {
                await DatabaseService.deletePaper(
                    _char!.id, _relationships[index].id);
                setState(() {
                  _relationships.removeAt(index);
                });
                Provider.of<LoginProvider>(context, listen: false)
                    .updateUser(char: _char);
              },
              buttonAdd: ButtonComponent(
                pressed: () async {
                  List<String>? resultado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPaperPage(
                        title: "Relacionamento",
                        body: true,
                      ),
                    ),
                  );

                  String? itemId;

                  if (resultado != null) {
                    var paper = PapersModel(
                        id: '',
                        title: resultado[0],
                        description: resultado[1],
                        tipo: 'relationship');
                    try {
                      itemId = await DatabaseService.addPaper(_char!.id, paper);
                      _relationships.add(paper);
                    } catch (e) {
                      NotificationHelper.showSnackBar(context,
                          "Relacionamento ${itemId != null ? "Adicionado" : "Não adicionado"}",
                          level: itemId != null ? 1 : 0);
                    }
                  }
                },
                tipo: 3,
                icon: PhosphorIconsBold.plus,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SectionComponent(
              title: 'Anotações',
              list: _notes,
              selectedItem: (index) {
                showModalBottomSheet(
                  context: context,
                  useSafeArea: true,
                  isScrollControlled: true,
                  showDragHandle: false,
                  barrierColor: Color.fromARGB(255, 229, 201, 144),
                  builder: (context) => PapersBSComponent(paper: _notes[index]),
                );
              },
              removeItem: (index) async {
                await DatabaseService.deletePaper(_char!.id, _notes[index].id);
                setState(() {
                  _notes.removeAt(index);
                });
                Provider.of<LoginProvider>(context, listen: false)
                    .updateUser(char: _char);
              },
              buttonAdd: ButtonComponent(
                pressed: () async {
                  List<String>? resultado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPaperPage(
                        title: "Nota",
                        body: true,
                      ),
                    ),
                  );

                  String? itemId;

                  if (resultado != null) {
                    var paper = PapersModel(
                        id: '',
                        title: resultado[0],
                        description: resultado[1],
                        tipo: 'note');
                    try {
                      itemId = await DatabaseService.addPaper(_char!.id, paper);
                      _relationships.add(paper);
                    } catch (e) {
                      NotificationHelper.showSnackBar(context,
                          "Nota ${itemId != null ? "Adicionada" : "Não adicionada"}",
                          level: itemId != null ? 1 : 0);
                    }
                  }
                },
                tipo: 3,
                icon: PhosphorIconsBold.plus,
              )),
        ),
      ],
    );
  }
}
