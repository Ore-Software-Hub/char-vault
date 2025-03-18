import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/components/dialog.component.dart';
import 'package:CharVault/constants/strings.constants.dart';
import 'package:CharVault/helpers/notification.helper.dart';
import 'package:CharVault/helpers/shared_preferences.helper.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/pages/edit_character.page.dart';
import 'package:CharVault/pages/initial.page.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:CharVault/services/database_service.dart';
import 'package:CharVault/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:auto_scroll_text/auto_scroll_text.dart';

class CharDetailsComponent extends StatefulWidget {
  const CharDetailsComponent(
      {super.key, required this.char, required this.updated});

  final CharacterModel char;
  final Function() updated;

  @override
  State<CharDetailsComponent> createState() => _CharDetailsComponentState();
}

class _CharDetailsComponentState extends State<CharDetailsComponent> {
  bool deleting = false;
  String urlImage = "";

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  loadImage() async {
    var url = await StorageService.getImageDownloadUrl(widget.char.image);
    setState(() {
      urlImage = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          spacing: 5,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              // Faz o container ocupar o espaço restante
              child: Container(
                height: 55,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  onTap: () {
                    Provider.of<LoginProvider>(context, listen: false)
                        .updateUser(char: widget.char);
                    SharedPreferencesHelper.removeMany(
                        [Constants.iniciative, Constants.inspiration, Constants.selectedMagic]);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InitialPage()),
                      (route) => false,
                    );
                  },
                  child: Row(
                    spacing: 5,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSecondary,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Image.network(urlImage, errorBuilder:
                            (BuildContext context, Object exception,
                                StackTrace? stackTrace) {
                          return LoadingAnimationWidget.beat(
                              color: Colors.black, size: 40);
                        }),
                      ),
                      Expanded(
                        // Garante que o Column ocupe todo o espaço restante
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoScrollText(
                              delayBefore: Duration(seconds: 5),
                              pauseBetween: Duration(seconds: 5),
                              mode: AutoScrollTextMode.bouncing,
                              velocity:
                                  Velocity(pixelsPerSecond: Offset(30, 0)),
                              widget.char.name,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Nível ${widget.char.details.level}",
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonComponent(
                  pressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditCharacterPage(char: widget.char)));
                  },
                  tipo: 3,
                  icon: PhosphorIconsBold.pencilSimple,
                ),
                if (!deleting)
                  ButtonComponent(
                    pressed: () async {
                      bool confirmed = await showDialog(
                          context: context,
                          builder: (BuildContext context) => DialogComponent(
                              title: "Remover Personagem",
                              type: "question",
                              message:
                                  'Deseja realmente excluir o personagem ${widget.char.name}'));

                      if (confirmed) {
                        setState(() {
                          deleting = true;
                        });
                        var charId = widget.char.id;
                        var charImageId = widget.char.image;

                        await DatabaseService.deleteCharacter(
                            charId, charImageId);

                        NotificationHelper.showSnackBar(context,
                            "Personagem ${widget.char.name} foi removido!");

                        setState(() {
                          deleting = false;
                        });

                        widget.updated();
                      }
                    },
                    tipo: 3,
                    icon: PhosphorIconsBold.trash,
                  ),
                if (deleting)
                  Center(
                    child: LoadingAnimationWidget.waveDots(
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: 30),
                  )
              ],
            ),
          ],
        ));
  }
}
