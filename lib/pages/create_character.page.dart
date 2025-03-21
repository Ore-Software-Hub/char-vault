import 'dart:io';
import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/components/dialog.component.dart';
import 'package:CharVault/components/dropdown.component.dart';
import 'package:CharVault/components/section.component.dart';
import 'package:CharVault/components/textfield.component.dart';
import 'package:CharVault/helpers/notification.helper.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/class.model.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:CharVault/models/paper.model.dart';
import 'package:CharVault/pages/add_item.page.dart';
import 'package:CharVault/pages/add_paper.page.dart';
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

  List<ItemModel> inventory = [];

  List<ClassModel> classes = [];
  ClassModel? classChar;
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

  List<PapersModel> talents = [], relationships = [];

  List<Currency> currency = [];

  List<String> languages = ['Comum'],
      immunities = [],
      resistance = [],
      vulnerabilities = [];

  String title = 'Dados Pessoais',
      savingTitle = '',
      _name = "",
      _age = "",
      _race = "",
      _height = "",
      _weight = "",
      _background = "",
      _alignment = "",
      _backstory = "",
      _classe = "",
      _level = "",
      _strength = "",
      _dexterity = "",
      _constitution = "",
      _intelligence = "",
      _wisdom = "",
      _charisma = "";

  CharacterModel? _char;

  @override
  void initState() {
    super.initState();
    loadClasses();
  }

  loadClasses() async {
    List<ClassModel> classModel = [];
    var items = await DatabaseService.getClasses();
    for (var item in items) {
      classModel.add(item);
    }
    if (mounted) {
      setState(() {
        classes = classModel;
      });
    }
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
        title = 'Inventário';
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
                        child: Icon(Icons.image,
                            color: Theme.of(context).colorScheme.surface),
                      )),
                  title: const Text("Galeria"),
                  onTap: () => {Navigator.pop(context), pickImage()},
                ),
                ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.onSurface,
                      child: Center(
                        child: Icon(Icons.delete_forever_outlined,
                            color: Theme.of(context).colorScheme.surface),
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
      case 1: // Dados pessoais
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
                          color: Colors.black.withAlpha(100),
                          borderRadius:
                              BorderRadius.circular(10), //<-- SEE HERE
                        ),
                        child: IconButton(
                            onPressed: () {
                              selectImage();
                            },
                            icon: const Icon(
                              Icons.image_search,
                              color: Colors.white,
                            ))),
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
      case 2: // Caracteristicas
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
                            classChar =
                                classes.firstWhere((cc) => cc.name == value);
                          })
                        },
                        hintText: "Classe",
                        items: classes
                            .map<ItemDropdown>((item) => ItemDropdown(
                                display: item.name, value: item.hp))
                            .toList(),
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
                        "Habilidades",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => DialogComponent(
                                  message:
                                      'Utilize os valores padrões (15, 14, 13, 12, 10 e 8) ou se preferir, jogue 4d6 então ignore o menor valor e some o restante'));
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
                      width: MediaQuery.of(context).size.width / 3,
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
                      width: MediaQuery.of(context).size.width / 3,
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
                      width: MediaQuery.of(context).size.width / 3,
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
                      width: MediaQuery.of(context).size.width / 3,
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
                      width: MediaQuery.of(context).size.width / 3,
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
                      width: MediaQuery.of(context).size.width / 3,
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
            SectionComponent(
              title: "Idiomas",
              list: languages,
              removeItem: (index) async {
                setState(() {
                  languages.removeAt(index);
                });
              },
              buttonAdd: ButtonComponent(
                pressed: () async {
                  List<String>? resultado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPaperPage(
                        title: "Idioma",
                      ),
                    ),
                  );

                  if (resultado != null) {
                    setState(() {
                      languages.add(resultado[0]);
                    });
                  }
                },
                tipo: 3,
                icon: PhosphorIconsBold.plus,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SectionComponent(
              title: "Talentos",
              list: talents,
              removeItem: (index) async {
                setState(() {
                  talents.removeAt(index);
                });
              },
              buttonAdd: ButtonComponent(
                pressed: () async {
                  List<String>? resultado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPaperPage(
                        title: "Talento",
                        body: true,
                      ),
                    ),
                  );

                  if (resultado != null) {
                    setState(() {
                      talents.add(PapersModel(
                          id: "",
                          title: resultado[0],
                          description: resultado[1],
                          tipo: "talent"));
                    });
                  }
                },
                tipo: 3,
                icon: PhosphorIconsBold.plus,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SectionComponent(
              title: "Vulnerabilidades",
              list: vulnerabilities,
              removeItem: (index) async {
                setState(() {
                  vulnerabilities.removeAt(index);
                });
              },
              buttonAdd: ButtonComponent(
                pressed: () async {
                  List<String>? resultado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPaperPage(
                        title: "Vulnerabilidade",
                      ),
                    ),
                  );

                  if (resultado != null) {
                    setState(() {
                      vulnerabilities.add(resultado[0]);
                    });
                  }
                },
                tipo: 3,
                icon: PhosphorIconsBold.plus,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SectionComponent(
              title: "Resistências",
              list: resistance,
              removeItem: (index) async {
                setState(() {
                  resistance.removeAt(index);
                });
              },
              buttonAdd: ButtonComponent(
                pressed: () async {
                  List<String>? resultado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPaperPage(
                        title: "Resistência",
                      ),
                    ),
                  );

                  if (resultado != null) {
                    setState(() {
                      resistance.add(resultado[0]);
                    });
                  }
                },
                tipo: 3,
                icon: PhosphorIconsBold.plus,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SectionComponent(
              title: "Imunidades",
              list: immunities,
              removeItem: (index) async {
                setState(() {
                  immunities.removeAt(index);
                });
              },
              buttonAdd: ButtonComponent(
                pressed: () async {
                  List<String>? resultado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPaperPage(
                        title: "Imunidade",
                      ),
                    ),
                  );

                  if (resultado != null) {
                    setState(() {
                      immunities.add(resultado[0]);
                    });
                  }
                },
                tipo: 3,
                icon: PhosphorIconsBold.plus,
              ),
            ),
          ],
        );
      case 3: // Inventário
        return Column(
          children: [
            SectionComponent(
              title: "Dinheiro",
              list: currency,
              removeItem: (index) async {
                setState(() {
                  currency.removeAt(index);
                });
              },
              buttonAdd: ButtonComponent(
                pressed: () async {
                  List<String>? resultado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPaperPage(
                          title: "Moeda", body: true, keyboardType: 'number'),
                    ),
                  );

                  if (resultado != null) {
                    setState(() {
                      currency.add(Currency(
                          type: resultado[0], amount: int.parse(resultado[1])));
                    });
                  }
                },
                tipo: 3,
                icon: PhosphorIconsBold.plus,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SectionComponent(
              title: "Relacionamentos",
              list: relationships,
              removeItem: (index) async {
                setState(() {
                  relationships.removeAt(index);
                });
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

                  if (resultado != null) {
                    setState(() {
                      relationships.add(PapersModel(
                          id: "",
                          title: resultado[0],
                          description: resultado[1],
                          tipo: "relationship"));
                    });
                  }
                },
                tipo: 3,
                icon: PhosphorIconsBold.plus,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SectionComponent(
              title: "Armas, Itens & Magias",
              list: inventory,
              removeItem: (index) async {
                setState(() {
                  inventory.removeAt(index);
                });
              },
              buttonAdd: ButtonComponent(
                pressed: () async {
                  ItemModel? resultado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddItemPage(),
                    ),
                  );

                  if (resultado != null) {
                    setState(() {
                      inventory.add(resultado);
                    });
                  }
                },
                tipo: 3,
                icon: PhosphorIconsBold.plus,
              ),
            ),
          ],
        );
      case 4: // Salvar
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

  getLife(FeatureDetails cons) {
    List<int> life = [];
    var classe = classes.firstWhere((classe) => classe.name == _classe);

    var maxLife = CharacterModel.calculateLife(
        classe.hp, int.parse(_level), cons.modifier!);

    life.add(maxLife);
    life.add(maxLife);

    return life;
  }

  int getProficiencyBonus(int level) {
    if (level >= 17) return 6;
    return ((level - 1) ~/ 4) + 2;
  }

  getSavingThrows(List<FeatureDetails> features) {
    var classe = classes.firstWhere((classe) => classe.name == _classe);

    var proficiencies = classe.savingThrows;

    List<FeatureDetails> savingThrows = features;

    for (var feat in savingThrows) {
      if (proficiencies.contains(feat.title)) {
        feat.savingThrow =
            feat.modifier! + getProficiencyBonus(int.parse(_level));
      }
    }

    return savingThrows;
  }

  FeatureDetails getFeatureDetails(
      String title, int value, int modifier, List<String> skills) {
    var newskills =
        skills.map((skill) => SkillDetails(skill, modifier)).toList();

    var feat = FeatureDetails(
      title: title,
      value: value,
      modifier: modifier,
      skills: newskills,
      savingThrow: null,
    );
    return feat;
  }

  finishCharacter() async {
    changeStep(1);
    var imgname = '';
    setState(() {
      savingTitle = "Carregando imagem";
    });

    try {
      imgname = await StorageService.uploadUserImage(_name, imageFile!);
      NotificationHelper.showSnackBar(context, "Imagem salva!",
          level: 'success');
    } catch (e) {
      NotificationHelper.showSnackBar(
          context, "Erro ao salvar imagem: ${e.toString()}",
          level: 'error');
      changeStep(-1);
      return;
    }

    var strength = getFeatureDetails("Força", int.tryParse(_strength)!,
        ((int.tryParse(_strength)! - 10) / 2).floor(), ["Atletismo"]);
    var dexterity = getFeatureDetails(
        "Destreza",
        int.tryParse(_dexterity)!,
        ((int.tryParse(_dexterity)! - 10) / 2).floor(),
        ["Acrobacia", "Furtividade", "Prestidigitação"]);
    var constitution = getFeatureDetails(
        "Constituição",
        int.tryParse(_constitution)!,
        ((int.tryParse(_constitution)! - 10) / 2).floor(), []);
    var intelligence = getFeatureDetails(
        "Inteligência",
        int.tryParse(_intelligence)!,
        ((int.tryParse(_intelligence)! - 10) / 2).floor(),
        ["Arcanismo", "História", "Investigação", "Natureza", "Religião"]);
    var wisdom = getFeatureDetails("Sabedoria", int.tryParse(_wisdom)!,
        ((int.tryParse(_wisdom)! - 10) / 2).floor(), [
      "Intuição",
      "Medicina",
      "Lidar com Animais",
      "Percepção",
      "Sobrevivência"
    ]);
    var charisma = getFeatureDetails(
        "Carisma",
        int.tryParse(_charisma)!,
        ((int.tryParse(_charisma)! - 10) / 2).floor(),
        ["Atuação", "Enganação", "Intimidação", "Persuasão"]);

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
      level: int.parse(_level),
      age: int.parse(_age),
      proficiency: getProficiencyBonus(int.parse(_level)),
      race: _race,
      height: _height,
      weight: _weight,
      alignment: _alignment,
      background: _background,
      backstory: _backstory,
      classModel: classChar!,
      languages: languages,
      armorClass: 0,
      movement: 9,
      immunities: immunities,
      vulnerabilities: vulnerabilities,
      resistancies: resistance,
    );

    _char = CharacterModel(
      id: '',
      image: imgname,
      name: _name,
      status: [],
      currency: currency,
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
          level: 'success');
    } catch (e) {
      NotificationHelper.showSnackBar(
          context, "Erro ao salvar o personagem: ${e.toString()}",
          level: 'error');
      await StorageService.deleteImageById(imgname);
      changeStep(-1);
      return;
    }

    if (charId != null) {
      if (inventory.isNotEmpty) {
        setState(() {
          savingTitle = "Salvando itens";
        });
        try {
          for (var item in inventory) {
            await DatabaseService.addItem(charId, item);
          }
          NotificationHelper.showSnackBar(context, "Itens adicionados!",
              level: 'success');
        } catch (e) {
          NotificationHelper.showSnackBar(
              context, "Erro ao adicionar itens: ${e.toString()}",
              level: 'error');
          return;
        }
      }

      if (talents.isNotEmpty) {
        setState(() {
          savingTitle = "Salvando talentos";
        });
        try {
          for (var talent in talents) {
            await DatabaseService.addPaper(charId, talent);
          }
          NotificationHelper.showSnackBar(context, "Talentos adicionados!",
              level: 'success');
        } catch (e) {
          NotificationHelper.showSnackBar(
              context, "Erro ao adicionar: ${e.toString()}",
              level: 'error');
          return;
        }
      }

      if (relationships.isNotEmpty) {
        setState(() {
          savingTitle = "Salvando itens";
        });
        try {
          for (var relation in relationships) {
            await DatabaseService.addPaper(charId, relation);
          }
          NotificationHelper.showSnackBar(
              context, "Relacionamentos adicionados!",
              level: 'success');
        } catch (e) {
          NotificationHelper.showSnackBar(
              context, "Erro ao adicionar: ${e.toString()}",
              level: 'error');
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
            context, "Preencha todos os campos para prosseguir",
            level: 'warning');
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
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(8),
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom +
              16, // Empurra o botão para cima quando o teclado aparece
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
            if (step < 3)
              ButtonComponent(
                label: "Próximo",
                pressed: nextAvailable(),
              ),
            if (step == 3)
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
