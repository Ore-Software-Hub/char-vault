import 'dart:io';

import 'package:CharVault/components/bottomsheet/add_item_component.dart';
import 'package:CharVault/components/button_component.dart';
import 'package:CharVault/components/dropdown_component.dart';
import 'package:CharVault/components/item_component.dart';
import 'package:CharVault/components/skills_component.dart';
import 'package:CharVault/components/text_field_component.dart';
import 'package:CharVault/services/storage_service.dart';
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
                // Stack(
                //   clipBehavior: Clip.none,
                //   alignment: AlignmentDirectional.center,
                //   children: [
                //     Container(
                //       width: 100,
                //       height: 100,
                //       decoration: BoxDecoration(
                //         color: cores.gray,
                //         borderRadius: BorderRadius.circular(50),
                //       ),
                //       child: Container(
                //         padding: const EdgeInsets.all(2),
                //         child: ClipRRect(
                //           borderRadius: BorderRadius.circular(50),
                //           child: Image.asset(
                //             'assets/img/eu.jpg',
                //             width: 75.0,
                //             height: 75.0,
                //           ),
                //         ),
                //       ),
                //     ),
                //     Positioned(
                //       bottom: 0,
                //       right: 0,
                //       child: Container(
                //         width: 30,
                //         height: 30,
                //         decoration: BoxDecoration(
                //           color: cores.primaryColor,
                //           borderRadius: BorderRadius.circular(50),
                //         ),
                //         child: Container(
                //           alignment: AlignmentDirectional.center,
                //           child: IconButton(
                //             onPressed: () {},
                //             icon: const PhosphorIcon(
                //               PhosphorIconsBold.plus,
                //               color: Colors.white,
                //               size: 15,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Stack(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 5,
                            color: Theme.of(context).colorScheme.surface),
                        borderRadius: BorderRadius.circular(100), //<-- SEE HERE
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
                            shape: BoxShape.circle),
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
                  child: const TextFieldComponent(
                    label: "Nome do personagem",
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
                      child: const TextFieldComponent(
                        label: "Idade",
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 10,
                      child: DropdownComponent(
                        onChanged: (value) {},
                        hintText: "Raça",
                        items: const ["Humano", "Anão", "Elfo", "Orc", "Gnomo"],
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
                      child: const TextFieldComponent(
                        label: "Antecedente",
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 10,
                      child: DropdownComponent(
                        onChanged: (value) {},
                        hintText: "Ética",
                        items: const [
                          "Legal Bom",
                          "Legal Mau",
                          "Legal Neutro",
                          "Neutro Bom",
                          "Neutro",
                          "Neutro Mau",
                          "Caótico Neutro",
                          "Caótico Bom",
                          "Caótico Mau"
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const TextFieldComponent(
                    maxlines: 8,
                    label: "História sobre o personagem",
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
                        onChanged: (value) {},
                        hintText: "Classe",
                        items: const [
                          "Bárbaro",
                          "Bardo",
                          "Clérigo",
                          "Druida",
                          "Guerreiro",
                          "Monge",
                          "Paladino",
                          "Patrulheiro",
                          "Ladino",
                          "Feiticeiro",
                          "Bruxo",
                          "Mago"
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const TextFieldComponent(
                        label: "Idade",
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
                      child: const TextFieldComponent(
                        label: "Força",
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: const TextFieldComponent(
                        label: "Destreza",
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: const TextFieldComponent(
                        label: "Constituição",
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: const TextFieldComponent(
                        label: "Inteligência",
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: const TextFieldComponent(
                        label: "Sabedoria",
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: const TextFieldComponent(
                        label: "Carisma",
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

  finishCharacter() async {
    changeStep(1);
    var imgurl = await StorageService.upload(imageFile!.path, imageFile!);
    debugPrint(imgurl);
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
                pressed: () {
                  changeStep(1);
                },
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
