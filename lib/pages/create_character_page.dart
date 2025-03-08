import 'dart:io';
import 'package:CharVault/components/button_component.dart';
import 'package:CharVault/components2/dropdown.component.dart';
import 'package:CharVault/components/item_component.dart';
import 'package:CharVault/components2/textfield.component.dart';
import 'package:CharVault/helpers/notification_helper.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:CharVault/services/database_service.dart';
import 'package:CharVault/services/storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreateCharacterPage extends StatefulWidget {
  const CreateCharacterPage({super.key});

  @override
  State<CreateCharacterPage> createState() => _CreateCharacterPageState();
}

class _CreateCharacterPageState extends State<CreateCharacterPage> {
  int step = 1;

  bool buscando = false, removeImage = false;

  File? imageFile;

  List<ItemModel> equipments = [], weapons = [], inventory = [], spells = [];

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

  List<Papers> missions = [], relationships = [], notes = [];

  List<Map<String, int>> currency = [];

  List<Map<String, String>> status = [], talents = [];

  List<String> languages = [], immunities = [], resistance = [], vulnerabilities = [];

  String title = 'Dados Pessoais';
  String savingTitle = '';
  String _name = "";
  String _age = "";
  String _race = "";
  String _height = "";
  String _weight = "";
  String _background = "";
  String _alignment = "";
  String _backstory = "";
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
        title = 'Características & Inventário';
        break;
      case 3:
        title = 'Salvar Personagem';
        break;
    }

    setState(() {
      step = newStep;
    });
  }

  Widget getImage() {
    if (removeImage || imageFile == null) {
      return Image.asset(
        'assets/img/profile_icon.png', // Replace with your image URL
        width: 100.0,
        height: 100.0, // Adiciona uma chave única baseada no caminho do arquivo
      );
    }

    return Image.file(
      File(imageFile!.path), // Replace with your image URL
      width: 100.0,
      height: 100.0, // Adiciona uma chave única baseada no caminho do arquivo
    );
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

  pickImage() async {
    final pickedFile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['png']);

    if (pickedFile == null) {
      setState(() {
        removeImage = false;
      });
      return;
    }

    setState(() {
      imageFile = File(pickedFile.files.single.path!);
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
                          Icons.image,
                          color: Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(.6),
                        ),
                      )),
                  title: const Text("Galeria"),
                  onTap: () => {Navigator.pop(context), pickImage()},
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
                    value: _name,
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
                        value: _age,
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
                      child: TextFieldComponent(
                        value: _height,
                        label: "Altura",
                        keyboardType: TextInputType.number,
                        onChanged: (value) => {
                          setState(() {
                            _height = value;
                          })
                        },
                      ),
                    ),
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
                        value: _weight,
                        label: "Peso",
                        keyboardType: TextInputType.number,
                        onChanged: (value) => {
                          setState(() {
                            _weight = value;
                          })
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 10,
                      child: DropdownComponent(
                        value: _race,
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
                        value: _background,
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
                        value: _alignment,
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
                    value: _backstory,
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
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: getImage(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  _name,
                  style: const TextStyle(
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
                        value: _classe,
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
                        value: _level,
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
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Insira os valores da habilidades",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // showModalBottomSheet(
                          //   context: context,
                          //   isScrollControlled: true,
                          //   builder: (context) =>
                          //       const TextBottomSheetComponent(
                          //     textList: [
                          //       "Utilize valores padrão(15, 14, 13, 12, 10, 8)",
                          //       "Ou role 4d6, depois descarte o menor valor e some o restante para cada atributo"
                          //     ],
                          //   ),
                          // );
                        },
                        icon: const PhosphorIcon(PhosphorIconsRegular.info),
                      )
                    ],
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
                        keyboardType: TextInputType.number,
                        value: _strength,
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
                        keyboardType: TextInputType.number,
                        value: _dexterity,
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
                        keyboardType: TextInputType.number,
                        value: _constitution,
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
                        keyboardType: TextInputType.number,
                        value: _intelligence,
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
                        keyboardType: TextInputType.number,
                        value: _wisdom,
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
                        keyboardType: TextInputType.number,
                        value: _charisma,
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
                  height: 10,
                ),
                const Text(
                  "Os valores dos testes de perícia serão calculados automaticamente!",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              indent: 20,
              endIndent: 20,
            ),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Equipamentos",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      equipments.isEmpty
                          ? returnInformation("Nenhum Equipamento adicionado!",
                              "Adicione um novo!")
                          : returnItemComponent(equipments)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Inventário",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      inventory.isEmpty
                          ? returnInformation(
                              "Nenhum item adicionado!", "Adicione um novo!")
                          : returnItemComponent(inventory)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Armas",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      weapons.isEmpty
                          ? returnInformation(
                              "Nenhuma arma encontrada!", "Adicione uma nova!")
                          : returnItemComponent(weapons)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Magias",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      spells.isEmpty
                          ? returnInformation(
                              "Nenhuma magia adicionada", "Adicione uma nova!")
                          : returnItemComponent(spells)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        );
      case 3:
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text(
                savingTitle,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              const Text(
                'Adicionando ao cofre...',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 50),
              LoadingAnimationWidget.discreteCircle(
                  color: Theme.of(context).colorScheme.secondary, size: 50)
            ],
          ),
        );
      default:
        return const Center();
    }
  }

  Widget returnInformation(String text, String subtext) {
    return Row(
      children: [
        const SizedBox(
          height: 50,
          width: 50,
          child: PhosphorIcon(PhosphorIconsBold.placeholder),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(subtext),
          ],
        )
      ],
    );
  }

  Widget returnItemComponent(List<ItemModel> items) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0, // Espaçamento horizontal entre os widgets
      runSpacing: 4.0, // Espaçamento vertical entre as linhas
      children: items.map<Row>((item) {
        return Row(
          children: [
            Expanded(
              child: ItemComponent(
                charId: '',
                item: item,
              ),
            ),
            ButtonComponent(
                pressed: () {
                  setState(() {
                    items.remove(item);
                  });
                },
                tipo: 0,
                icon: PhosphorIconsBold.minus)
          ],
        );
      }).toList(),
    );
  }

  getLife(FeatureDetails cons) {
    List<String> life = [];
    var classe = classes.firstWhere((classe) => classe.display == _classe);

    var maxLife = CharacterModel.calculateLife(
        classe.value, int.parse(_level), cons.modifier!);

    life.add(maxLife);
    life.add(maxLife);

    return life;
  }

  int getProficiencyBonus(int level) {
    if (level >= 17) return 6;
    return ((level - 1) ~/ 4) + 2;
  }

  getSavingThrows(List<FeatureDetails> features) {
    var classesProficiencies = {
      'Bárbaro': ['Força', 'Constituição'],
      'Bardo': ['Destreza', 'Carisma'],
      'Bruxo': ['Sabedoria', 'Carisma'],
      'Clérigo': ['Sabedoria', 'Carisma'],
      'Druida': ['Inteligência', 'Sabedoria'],
      'Feiticeiro': ['Constituição', 'Carisma'],
      'Guerreiro': ['Força', 'Constituição'],
      'Ladino': ['Destreza', 'Inteligência'],
      'Mago': ['Inteligência', 'Sabedoria'],
      'Paladino': ['Sabedoria', 'Carisma'],
    };

    var classe = classes.firstWhere((classe) => classe.display == _classe);

    var proficiencies = classesProficiencies[classe.display]!;

    List<FeatureDetails> savingThrows = features;

    for (var feat in savingThrows) {
      if (proficiencies.contains(feat.title)) {
        feat.savingThrow =
            feat.modifier! + getProficiencyBonus(int.parse(_level));
      }
    }

    return savingThrows;
  }

  finishCharacter() async {
    changeStep(1);
    var imgname = '';
    setState(() {
      savingTitle = "Carregando imagem";
    });

    try {
      imgname = await StorageService.uploadUserImage(_name, imageFile!);
      NotificationHelper.showSnackBar(context, "Imagem salva!", level: 1);
    } catch (e) {
      NotificationHelper.showSnackBar(
          context, "Erro ao salvar imagem: ${e.toString()}",
          level: 2);
      changeStep(-1);
      return;
    }

    var strength = FeatureDetails(
        title: "Força",
        value: int.tryParse(_strength)!,
        modifier: ((int.tryParse(_strength)! - 10) / 2).floor(),
        skill: ["Atletismo"]);
    var dexterity = FeatureDetails(
        title: "Destreza",
        value: int.tryParse(_dexterity)!,
        modifier: ((int.tryParse(_dexterity)! - 10) / 2).floor(),
        skill: ["Acrobacia", "Furtividade", "Prestidigitação"]);
    var constitution = FeatureDetails(
      title: "Constituição",
      value: int.tryParse(_constitution)!,
      modifier: ((int.tryParse(_constitution)! - 10) / 2).floor(),
    );
    var intelligence = FeatureDetails(
        title: "Inteligência",
        value: int.tryParse(_intelligence)!,
        modifier: ((int.tryParse(_intelligence)! - 10) / 2).floor(),
        skill: [
          "Arcanismo",
          "História",
          "Investigação",
          "Natureza",
          "Religião"
        ]);
    var wisdom = FeatureDetails(
        title: "Sabedoria",
        value: int.tryParse(_wisdom)!,
        modifier: ((int.tryParse(_wisdom)! - 10) / 2).floor(),
        skill: [
          "Intuição",
          "Medicina",
          "Lidar com Animais",
          "Percepção",
          "Sobrevivência"
        ]);
    var charisma = FeatureDetails(
        title: "Carisma",
        value: int.tryParse(_charisma)!,
        modifier: ((int.tryParse(_charisma)! - 10) / 2).floor(),
        skill: ["Atuação", "Enganação", "Intimidação", "Persuasão"]);

    List<FeatureDetails> features = [
      strength,
      dexterity,
      constitution,
      intelligence,
      wisdom,
      charisma,
    ];

    features = getSavingThrows(features);

    var life = getLife(constitution);

    var details = CharacterDetails(
      curLife: life[0],
      maxLife: life[1],
      level: _level,
      classe: _classe,
      age: _age,
      race: _race,
      height: _height,
      weight: _weight,
      alignment: _alignment,
      background: _background,
      backstory: _backstory,
      languages: languages,
      talents: talents,
      armorClass: '',
      movement: '9',
      immunities: immunities,
      vulnerabilities: vulnerabilities,
      resistancies: resistance,
    );

    _char = CharacterModel(
      id: '',
      image: imgname,
      name: _name,
      status: status,
      currency: currency,
      notes: notes,
      missions: missions,
      relationships: relationships,
      details: details,
      features: features,
    );

    String? charId;

    setState(() {
      savingTitle = "Salvando personagem";
    });

    try {
      charId = await DatabaseService.addCharacter(_char!);
      NotificationHelper.showSnackBar(context, "Personagem adicionado!",
          level: 1);
    } catch (e) {
      NotificationHelper.showSnackBar(
          context, "Erro ao salvar o personagem: ${e.toString()}",
          level: 2);
      changeStep(-1);
      return;
    }

    if (charId != null) {
      List<ItemModel> items = [
        ...equipments,
        ...inventory,
        ...weapons,
        ...spells
      ];

      if (items.isNotEmpty) {
        setState(() {
          savingTitle = "Salvando itens";
        });
        try {
          for (var item in items) {
            await DatabaseService.addItem(charId, item);
          }
          NotificationHelper.showSnackBar(context, "Itens adicionados!",
              level: 1);
        } catch (e) {
          NotificationHelper.showSnackBar(
              context, "Erro ao adicionar itens: ${e.toString()}",
              level: 2);
          changeStep(-1);
          return;
        }
      }
    }

    Navigator.pop(context);
  }

  nextAvailable() {
    if (step == 1 &&
        (_name.isEmpty ||
            _age.isEmpty ||
            _race.isEmpty ||
            _background.isEmpty ||
            _alignment.isEmpty ||
            imageFile == null)) {
      return () {
        NotificationHelper.showSnackBar(
          context,
          "Preencha todos os campos para prosseguir",
        );
      };
    }

    return () {
      changeStep(1);
    };
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
                      color: Theme.of(context).colorScheme.primary,
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
      floatingActionButton: step == 2
          ? FloatingActionButton(
              onPressed: () async {
                // final item = await showModalBottomSheet<ItemModel>(
                //   backgroundColor: Theme.of(context).colorScheme.secondary,
                //   showDragHandle: true,
                //   context: context,
                //   isScrollControlled: true,
                //   builder: (context) => const AddItemBottomSheetComponent(
                //     editing: false,
                //   ),
                // );

                // if (item != null) {
                //   switch (item.tipo) {
                //     case 'Arma':
                //       setState(() {
                //         {
                //           weapons.add(item);
                //         }
                //       });
                //       break;

                //     case 'Armadura':
                //     case 'Equipamento':
                //     case 'Item':
                //       setState(() {
                //         {
                //           equipments.add(item);
                //         }
                //       });
                //       break;

                //     case 'Consumíveis':
                //     case 'Item mágico':
                //     case 'Objeto':
                //     case 'Outros':
                //       setState(() {
                //         {
                //           inventory.add(item);
                //         }
                //       });
                //       break;

                //     case 'Magia':
                //       setState(() {
                //         {
                //           spells.add(item);
                //         }
                //       });
                //       break;
                //   }
                // }
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
            ButtonComponent(
              label: "Voltar",
              pressed: () {
                changeStep(-1);
              },
            ),
            const Spacer(),
            if (step < 2)
              ButtonComponent(
                label: "Próximo",
                pressed: nextAvailable(),
              ),
            if (step == 2)
              ButtonComponent(
                label: "Finalizar",
                disabled: _classe.isEmpty ||
                    _level.isEmpty ||
                    _strength.isEmpty ||
                    _dexterity.isEmpty ||
                    _constitution.isEmpty ||
                    _intelligence.isEmpty ||
                    _wisdom.isEmpty ||
                    _charisma.isEmpty,
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
