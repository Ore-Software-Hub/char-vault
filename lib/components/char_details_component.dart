import 'package:CharVault/components/button_component.dart';
import 'package:CharVault/components2/dialog.component.dart';
import 'package:CharVault/helpers/notification_helper.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/pages/edit_character_page.dart';
import 'package:CharVault/pages/initial_page.dart';
import 'package:CharVault/pages/user_profile_page.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:CharVault/services/database_service.dart';
import 'package:CharVault/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class CharDetailsComponent extends StatefulWidget {
  const CharDetailsComponent({super.key, required this.char});

  final CharacterModel char;

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
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary, // Sem preenchimento
          borderRadius: BorderRadius.circular(10.0), // Raio da borda
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Provider.of<LoginProvider>(context, listen: false)
                    .updateUser(char: widget.char);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const InitialPage()),
                  (route) => false,
                );
              },
              child: Row(
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
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.char.name,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Nível ${widget.char.details.level}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                ButtonComponent(
                  pressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditCharacterPage(char: widget.char)));
                  },
                  tipo: 0,
                  icon: PhosphorIconsBold.pencilSimple,
                ),
                if (!deleting)
                  ButtonComponent(
                    pressed: () async {
                      bool confirmed = await showDialog(
                          context: context,
                          builder: (BuildContext context) => DialogComponent(
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

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserProfilePage()),
                          (route) => false,
                        );
                      }
                    },
                    tipo: 0,
                    icon: PhosphorIconsBold.trash,
                  ),
                if (deleting)
                  Center(
                    child: LoadingAnimationWidget.waveDots(
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: 30),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
