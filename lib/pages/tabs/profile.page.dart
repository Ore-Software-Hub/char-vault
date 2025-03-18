import 'package:CharVault/components/line.component.dart';
import 'package:CharVault/components/header.component.dart';
import 'package:CharVault/components/list.component.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/paper.model.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:CharVault/services/database_service.dart';
import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  CharacterModel? _char;
  List<PapersModel> _talents = [];

  @override
  void initState() {
    super.initState();
    _char = Provider.of<LoginProvider>(context, listen: false).userModel!.char;
    loadTalents();
  }

  loadTalents() async {
    List<PapersModel> talents = [];
    var papers = await DatabaseService.getCharPapers(_char!.id);
    for (var paper in papers) {
      switch (paper.tipo) {
        case 'talent':
          talents.add(paper);
          break;
      }
    }
    if (mounted) {
      setState(() {
        _talents = talents;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderComponent(
          type: 2,
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sobre",
                style: AppTextStyles.boldText(context,
                    size: 20, color: Theme.of(context).colorScheme.onSurface),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceBetween,
                spacing: 4.0, // Espaçamento horizontal entre os widgets
                runSpacing: 8.0, // Espaçamento vertical entre as linhas
                children: [
                  LineComponent(
                      line: true,
                      valueString: true,
                      title: "Idade",
                      value: "${_char!.details.age}"),
                  LineComponent(
                      line: true,
                      valueString: true,
                      title: "Altura",
                      value: _char!.details.height),
                  LineComponent(
                      line: true,
                      valueString: true,
                      title: "Peso",
                      value: _char!.details.weight),
                  LineComponent(
                      line: true,
                      title: "Antecedentes",
                      value: _char!.details.background),
                  LineComponent(
                      line: true,
                      title: "Alinhamento",
                      value: _char!.details.alignment),
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
                child: Text(_char!.details.backstory),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Outras Informações",
                    style: AppTextStyles.boldText(context,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),
              ListComponent(title: "Idiomas", list: _char!.details.languages),
              SizedBox(
                height: 10,
              ),
              ListComponent(title: "Talentos", list: _talents),
            ],
          ),
        ),
        SizedBox(
          height: 100,
        )
      ],
    );
  }
}
