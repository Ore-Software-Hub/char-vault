import 'dart:io';

import 'package:CharVault/components/bottomsheet/add_item_component.dart';
import 'package:CharVault/components/button_component.dart';
import 'package:CharVault/components/dropdown_component.dart';
import 'package:CharVault/components/item_component.dart';
import 'package:CharVault/components/skills_component.dart';
import 'package:CharVault/components/text_field_component.dart';
import 'package:CharVault/helpers/notification_helper.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:flutter/material.dart';
import 'package:CharVault/constants/cores.constants.dart' as cores;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreateCharacterPage extends StatefulWidget {
  const CreateCharacterPage({super.key});

  @override
  State<CreateCharacterPage> createState() => _CreateCharacterPageState();
}

class _CreateCharacterPageState extends State<CreateCharacterPage> {
  int step = 1;
  String title = '';
  bool buscando = false;
  final imagePicker = ImagePicker();
  File? imageFile;
  bool removeImage = false;

  List<ItemDropdown> classes = [
    ItemDropdown(display: "Bárbaro", value: 12),
    ItemDropdown(display: "Bardo", value: 8),
    ItemDropdown(display: "Bruxo", value: 8),
    ItemDropdown(display: "Clérigo", value: 8),
    ItemDropdown(display: "Druida", value: 8),
    ItemDropdown(display: "Feiticeiro", value: 6),
    ItemDropdown(display: "Guerreiro", value: 10),
    ItemDropdown(display: "Ladino", value: 8),
    ItemDropdown(display: "Mago", value: 6),
    ItemDropdown(display: "Paladino", value: 10),
  ];

  List<ItemDropdown> alignments = [
    ItemDropdown(display: "Legal Bom", value: 0),
    ItemDropdown(display: "Legal Mau", value: 0),
    ItemDropdown(display: "Legal Neutro", value: 0),
    ItemDropdown(display: "Neutro Bom", value: 0),
    ItemDropdown(display: "Neutro", value: 0),
    ItemDropdown(display: "Neutro Mau", value: 0),
    ItemDropdown(display: "Caótico Neutro", value: 0),
    ItemDropdown(display: "Caótico Bom", value: 0),
    ItemDropdown(display: "Caótico Mau", value: 0),
  ];

  // Step 1
  String _name = "";
  String _age = "";
  String _race = "";
  String _background = "";
  String _alignment = "";
  String _backstory = "";

  // Step 2
  String _classe = "";
  String _level = "";
  String _strength = "";
  String _dexterity = "";
  String _constitution = "";
  String _intelligence = "";
  String _wisdom = "";
  String _charisma = "";

  CharacterModel? _char;

  @override
  void initState() {
    super.initState();
  }

  changeStep(int val) {
    int newStep = 0;
    newStep = step + val;

    switch (newStep) {
      case 0:
        Navigator.pop(context);
        break;
      case 1:
        title = 'Dados Pessoais';
        break;
      case 2:
        title = 'Características';
        break;
      case 3:
        title = 'Inventário & Combate';
        break;
      case 4:
        title = 'Salvar Personagem';
        break;
    }

    setState(() {
      step = newStep;
    });
  }

  Widget getImage() {
    if (removeImage) {
      return Image.asset(
        'assets/img/profile_icon.png', // Replace with your image URL
        width: 100.0,
        height: 100.0, // Adiciona uma chave única baseada no caminho do arquivo
      );
    }

    if (imageFile != null) {
      return Image.file(
        File(imageFile!.path), // Replace with your image URL
        width: 100.0,
        height: 100.0, // Adiciona uma chave única baseada no caminho do arquivo
      );
    }

    return Image.network(
        "user?.profile?.picture", // Replace with your image URL
        width: 100.0,
        height: 100.0,
        fit: BoxFit.cover, errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
      return const Text('😢');
    });
  }

  cropImage() async {
    final croppedFile = await ImageCropper().cropImage(
      compressFormat: ImageCompressFormat.png,
      sourcePath: imageFile!.path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Recortar',
            toolbarColor: Theme.of(context).colorScheme.primary,
            toolbarWidgetColor: Theme.of(context).colorScheme.onPrimary,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        // TODO: Add IOS
      ],
    );
    if (croppedFile != null) {
      setState(() {
        imageFile = File(croppedFile.path);
        removeImage = false;
      });
    } else {
      setState(() {
        imageFile = null;
      });
    }
  }

  pickImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile == null) {
      setState(() {
        removeImage = false;
      });
      return;
    }

    setState(() {
      imageFile = File(pickedFile.path);
    });

    await cropImage();
  }

  selectImage() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            height: 250,
            width: double.infinity,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 8),
                  child: Text(
                    "Editar Imagem",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.onSurface,
                      child: Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(.6),
                        ),
                      )),
                  title: const Text("Camera"),
                  onTap: () => {
                    debugPrint("Clicou "),
                    Navigator.pop(context),
                    pickImage(ImageSource.camera)
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.onSurface,
                      child: Center(
                        child: Icon(
                          Icons.image,
                          color: Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(.6),
                        ),
                      )),
                  title: const Text("Galeria"),
                  onTap: () => {
                    debugPrint("Clicou "),
                    Navigator.pop(context),
                    pickImage(ImageSource.gallery)
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.onSurface,
                      child: Center(
                        child: Icon(
                          Icons.delete_forever_outlined,
                          color: Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(.6),
                        ),
                      )),
                  title: const Text("Remover"),
                  onTap: () => {
                    Navigator.pop(context),
                    setState(() {
                      imageFile = null;
                      removeImage = true;
                    })
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget returnStep(int step) {
    switch (step) {
      case 1:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 5,
                            color: Theme.of(context).colorScheme.surface),
                        borderRadius: BorderRadius.circular(10), //<-- SEE HERE
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              100.0), // Adjust the radius as needed
                          child: getImage()),
                    ),
                    Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius:
                              BorderRadius.circular(10), //<-- SEE HERE
                        ),
                        child: IconButton(
                            onPressed: () {
                              selectImage();
                            },
                            icon: const Icon(Icons.image_search))),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Adicione uma foto",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Insira uma foto PNG com fundo transparente",
                      style: TextStyle(
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFieldComponent(
                    label: "Nome do personagem",
                    onChanged: (value) => {
                      setState(() {
                        _name = value;
                      })
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 10,
                      child: TextFieldComponent(
                        label: "Idade",
                        keyboardType: TextInputType.number,
                        onChanged: (value) => {
                          setState(() {
                            _age = value;
                          })
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 10,
                      child: DropdownComponent(
                        onChanged: (value) => {
                          setState(() {
                            _race = value!;
                          })
                        },
                        hintText: "Raça",
                        items: [
                          ItemDropdown(display: "Humano", value: 0),
                          ItemDropdown(display: "Anão", value: 0),
                          ItemDropdown(display: "Elfo", value: 0),
                          ItemDropdown(display: "Orc", value: 0),
                          ItemDropdown(display: "Gnomo", value: 0)
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 10,
                      child: TextFieldComponent(
                        label: "Antecedente",
                        onChanged: (value) => {
                          setState(() {
                            _background = value;
                          })
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 10,
                      child: DropdownComponent(
                        onChanged: (value) => {
                          setState(() {
                            _alignment = value!;
                          })
                        },
                        hintText: "Ética",
                        items: alignments,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFieldComponent(
                    maxlines: 8,
                    label: "História sobre o personagem",
                    onChanged: (value) => {
                      setState(() {
                        _backstory = value;
                      })
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      case 2:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: cores.gray,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/img/eu.jpg',
                        width: 75.0,
                        height: 75.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Garry Floyd",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: DropdownComponent(
                        onChanged: (value) => {
                          setState(() {
                            _classe = value!;
                          })
                        },
                        hintText: "Classe",
                        items: classes,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextFieldComponent(
                        label: "Nível",
                        keyboardType: TextInputType.number,
                        onChanged: (value) => {
                          setState(() {
                            _level = value;
                          })
                        },
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 5),
                  child: Text(
                    "Insira os valores da habilidades (15, 14, 13, 12, 10, 8)",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 4.0, // Espaçamento horizontal entre os widgets
                  runSpacing: 4.0, // Espaçamento vertical entre as linhas
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: TextFieldComponent(
                        label: "Força",
                        onChanged: (value) => {
                          setState(() {
                            _strength = value;
                          })
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: TextFieldComponent(
                        label: "Destreza",
                        onChanged: (value) => {
                          setState(() {
                            _dexterity = value;
                          })
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: TextFieldComponent(
                        label: "Constituição",
                        onChanged: (value) => {
                          setState(() {
                            _constitution = value;
                          })
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: TextFieldComponent(
                        label: "Inteligência",
                        onChanged: (value) => {
                          setState(() {
                            _intelligence = value;
                          })
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: TextFieldComponent(
                        label: "Sabedoria",
                        onChanged: (value) => {
                          setState(() {
                            _wisdom = value;
                          })
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: TextFieldComponent(
                        label: "Carisma",
                        onChanged: (value) => {
                          setState(() {
                            _charisma = value;
                          })
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Testes de Resistência",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 4.0, // Espaçamento horizontal entre os widgets
                      runSpacing: 4.0, // Espaçamento vertical entre as linhas
                      children: [
                        SkillsComponent(title: "Força", value: "+2"),
                        SkillsComponent(title: "Destreza", value: "+2"),
                        SkillsComponent(title: "Constituição", value: "-1"),
                        SkillsComponent(title: "Inteligência", value: "+2"),
                        SkillsComponent(title: "Sabedoria", value: "+3"),
                        SkillsComponent(title: "Carisma", value: "0"),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Habilidades",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 4.0, // Espaçamento horizontal entre os widgets
                      runSpacing: 4.0, // Espaçamento vertical entre as linhas
                      children: [
                        SkillsComponent(title: "Acrobacia", value: "+2"),
                        SkillsComponent(title: "Arcanismo", value: "+2"),
                        SkillsComponent(title: "Atletismo", value: "-1"),
                        SkillsComponent(title: "Atuação", value: "+2"),
                        SkillsComponent(title: "Enganação", value: "+3"),
                        SkillsComponent(title: "Furtividade", value: "0"),
                        SkillsComponent(title: "História", value: "+2"),
                        SkillsComponent(title: "Intimidação", value: "0"),
                        SkillsComponent(title: "Intuição", value: "0"),
                        SkillsComponent(title: "Investigação", value: "+2"),
                        SkillsComponent(title: "Lidar com Animais", value: "0"),
                        SkillsComponent(title: "Medicina", value: "-1"),
                        SkillsComponent(title: "Natureza", value: "+2"),
                        SkillsComponent(title: "Percepção", value: "0"),
                        SkillsComponent(title: "Persuação", value: "+2"),
                        SkillsComponent(title: "Prestidigitação", value: "0"),
                        SkillsComponent(title: "Religião", value: "0"),
                        SkillsComponent(title: "Sobrevivência", value: "-1"),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );

      case 3:
        return const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Equipamentos",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 4.0, // Espaçamento horizontal entre os widgets
                      runSpacing: 4.0, // Espaçamento vertical entre as linhas
                      children: [
                        ItemComponent(title: "title", tipo: 0),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Inventário",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 4.0, // Espaçamento horizontal entre os widgets
                      runSpacing: 4.0, // Espaçamento vertical entre as linhas
                      children: [
                        ItemComponent(title: "title", tipo: 0),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Armas",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 4.0, // Espaçamento horizontal entre os widgets
                      runSpacing: 4.0, // Espaçamento vertical entre as linhas
                      children: [
                        ItemComponent(title: "title", tipo: 0),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Magias",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 4.0, // Espaçamento horizontal entre os widgets
                      runSpacing: 4.0, // Espaçamento vertical entre as linhas
                      children: [
                        ItemComponent(title: "title", tipo: 0),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        );

      case 4:
        return Center(
          child: LoadingAnimationWidget.discreteCircle(
              color: Colors.black, size: 60),
        );
      default:
        return const Center();
    }
  }

  createFeature(String title, int value) {
    var modifier = 0;

    if (value >= 20) {
      modifier = 5;
    } else if (value >= 18) {
      modifier = 4;
    } else if (value >= 16) {
      modifier = 3;
    } else if (value >= 14) {
      modifier = 2;
    } else if (value >= 12) {
      modifier = 1;
    } else if (value >= 10) {
      modifier = 0;
    } else if (value >= 8) {
      modifier = -1;
    } else if (value >= 6) {
      modifier = -2;
    } else if (value >= 4) {
      modifier = -3;
    } else if (value >= 2) {
      modifier = -4;
    } else {
      modifier = -5;
    }

    return FeatureDetails(title, value, modifier);
  }

  List<SkillDetails> createSkill(List<String> items, FeatureDetails feature) {
    List<SkillDetails> result = [];

    for (var item in items) {
      var skill = SkillDetails(item, feature.modifier);

      result.add(skill);
    }

    return result;
  }

  getLife(FeatureDetails cons) {
    List<String> life = [];

    var classe = classes.firstWhere((classe) => classe.display == _classe);
    var maxLife = classe.value + cons.modifier;
    life.add(maxLife);
    life.add(maxLife);

    return life;
  }

  finishCharacter() async {
    changeStep(1);
    // var imgurl = await StorageService.upload(imageFile!.path, imageFile!);
    var details =
        CharacterDetails(_age, _race, _background, _alignment, _backstory);

    var strength = createFeature("Força", int.tryParse(_strength)!);
    var dexterity = createFeature("Destreza", int.tryParse(_dexterity)!);
    var constitution =
        createFeature("Constituição", int.tryParse(_constitution)!);
    var intelligence =
        createFeature("Inteligência", int.tryParse(_intelligence)!);
    var wisdom = createFeature("Sabedoria", int.tryParse(_wisdom)!);
    var charisma = createFeature("Carisma", int.tryParse(_charisma)!);

    List<FeatureDetails> features = [
      strength,
      dexterity,
      constitution,
      intelligence,
      wisdom,
      charisma,
    ];

    var skillStrength = createSkill(["Atletismo"], strength);
    var skillDex =
        createSkill(["Acrobacia", "Furtividade", "Prestidigitação"], dexterity);
    var skillIntel = createSkill(
        ["Arcanismo", "Investigação", "Natureza", "Religião"], intelligence);
    var skillWis = createSkill([
      "Intuição",
      "Lidar com Animais",
      "Medicina",
      "Percepção",
      "Sobrevivência"
    ], wisdom);
    var skillChar = createSkill(
        ["Atuação", "Enganação", "Intimidação", "Persuasão"], charisma);

    var skills = [
      ...skillStrength,
      ...skillDex,
      ...skillIntel,
      ...skillWis,
      ...skillChar
    ];

    var life = getLife(constitution);

    var po = "0";
    var pp = "0";
    var pb = "0";

    _char = CharacterModel(
        "https://i.pinimg.com/originals/02/f2/a6/02f2a6f010ab7885a6324d4f426312e9.png",
        _name,
        _classe,
        _level,
        life[0],
        life[1],
        po,
        pp,
        pb,
        details,
        features,
        skills);
  }

  nextAvailable() {
    if (step == 1 &&
        (_name.isEmpty ||
            _age.isEmpty ||
            _race.isEmpty ||
            _background.isEmpty ||
            _alignment.isEmpty)) {
      return () {
        NotificationHelper.showSnackBar(
            context, "Preencha todos os campos para prosseguir");
      };
    }

    if (step == 2 &&
        (_classe.isEmpty ||
            _level.isEmpty ||
            _strength.isEmpty ||
            _dexterity.isEmpty ||
            _constitution.isEmpty ||
            _intelligence.isEmpty ||
            _wisdom.isEmpty ||
            _charisma.isEmpty)) {
      return () {
        NotificationHelper.showSnackBar(
            context, "Preencha todos os campos para prosseguir");
      };
    }

    return changeStep(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo personagem'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                      color: cores.primaryColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: step == 4
                      ? const PhosphorIcon(
                          PhosphorIconsBold.floppyDisk,
                          color: Colors.white,
                          size: 15,
                        )
                      : Text(step.toString(),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            returnStep(step),
          ],
        )),
      ),
      floatingActionButton: step == 3
          ? FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: cores.secondaryColor,
                  showDragHandle: true,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => const AddItemBottomSheetComponent(
                    editing: false,
                  ),
                );
              },
              child: const PhosphorIcon(
                PhosphorIconsBold.plus,
              ),
            )
          : null,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),
        child: Row(
          children: [
            if (step <= 3)
              ButtonComponent(
                label: "Voltar",
                pressed: () {
                  changeStep(-1);
                },
                color: cores.gray,
              ),
            const Spacer(),
            if (step < 3)
              ButtonComponent(
                label: "Próximo",
                pressed: nextAvailable(),
              ),
            if (step == 3)
              ButtonComponent(
                label: "Finalizar",
                pressed: () {
                  finishCharacter();
                },
              )
          ],
        ),
      ),
    );
  }
}
