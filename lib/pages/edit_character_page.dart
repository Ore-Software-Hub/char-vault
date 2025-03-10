import 'dart:io';

import 'package:CharVault/components/button_component.dart';
import 'package:CharVault/components2/textfield.component.dart';
import 'package:CharVault/helpers/notification_helper.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/services/database_service.dart';
import 'package:CharVault/services/storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditCharacterPage extends StatefulWidget {
  const EditCharacterPage({super.key, required this.char});

  final CharacterModel char;

  @override
  State<EditCharacterPage> createState() => _CreateCharacterPageState();
}

class _CreateCharacterPageState extends State<EditCharacterPage> {
  int step = 1;

  bool buscando = false, removeImage = false;

  File? imageFile;

  String title = "Editando '";
  String savingTitle = '';
  String _name = "";
  String _backstory = "";
  String urlImage = "";
  bool changedImage = false;

  CharacterModel? _char;

  @override
  void initState() {
    super.initState();
    setState(() {
      title += "${widget.char.name}'";
      _name = widget.char.name;
      _backstory = widget.char.details.backstory;
    });
    loadImage();
  }

  loadImage() async {
    var url = await StorageService.getImageDownloadUrl(widget.char.image);
    setState(() {
      urlImage = url;
    });
  }

  changeStep(int val) {
    int newStep = 0;
    String newTitle = '';
    newStep = step + val;

    switch (newStep) {
      case 0:
        Navigator.pop(context);
        break;
      case 1:
        newTitle = 'Editar Personagem';
        break;
      case 2:
        newTitle = 'Salvar Personagem';
        break;
    }

    setState(() {
      step = newStep;
      title = newTitle;
    });
  }

  Widget getImage() {
    if (removeImage == true) {
      return Image.asset(
        'assets/img/profile_icon.png', // Replace with your image URL
        width: 100.0,
        height: 100.0, // Adiciona uma chave única baseada no caminho do arquivo
      );
    }

    if (imageFile == null) {
      return Image.network(urlImage, errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return LoadingAnimationWidget.beat(color: Colors.black, size: 40);
      });
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
        changedImage = true;
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
                          border: Border.all(color: Colors.black),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFieldComponent(
                    value: _backstory,
                    maxlines: 15,
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

  finishCharacter() async {
    changeStep(1);
    var imgname = '';
    if (changedImage) {
      setState(() {
        savingTitle = "Carregando imagem";
      });

      try {
        await StorageService.deleteImageById(widget.char.image);
        imgname = await StorageService.uploadUserImage(_name, imageFile!);
        NotificationHelper.showSnackBar(context, "Imagem salva!", level: 1);
      } catch (e) {
        NotificationHelper.showSnackBar(
            context, "Erro ao salvar imagem: ${e.toString()}",
            level: 2);
        changeStep(-1);
        return;
      }
    }

    _char = CharacterModel(
      id: widget.char.id,
      image: changedImage ? imgname : widget.char.image,
      name: _name,
      status: widget.char.status,
      currency: widget.char.currency,
      notes: widget.char.notes,
      missions: widget.char.missions,
      relationships: widget.char.relationships,
      details: widget.char.details,
      features: widget.char.features,
    );

    setState(() {
      savingTitle = "Salvando personagem";
    });

    try {
      await DatabaseService.updateCharacter(widget.char.id, _char!.toMap());
      NotificationHelper.showSnackBar(context, "Personagem atualizado!",
          level: 1);
    } catch (e) {
      NotificationHelper.showSnackBar(
          context, "Erro ao atualizar o personagem: ${e.toString()}",
          level: 2);
      changeStep(-1);
      return;
    }

    Navigator.pop(context);
  }

  nextAvailable() {
    if (step == 1 && (_name.isEmpty || imageFile == null)) {
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
      appBar: AppBar(),
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
