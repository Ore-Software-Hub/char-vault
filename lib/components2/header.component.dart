import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/user_model.dart';
import 'package:CharVault/pages/user_profile_page.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:CharVault/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class HeaderComponent extends StatefulWidget {
  const HeaderComponent({super.key, this.type = 1});

  final int type;

  @override
  State<HeaderComponent> createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {
  UserModel? _user;
  CharacterModel? _char;
  String urlImage = "";

  @override
  void initState() {
    super.initState();
    _user = Provider.of<LoginProvider>(context, listen: false).userModel!;
    _char = _user!.char;
    loadImage();
  }

  loadImage() async {
    var url = await StorageService.getImageDownloadUrl(_char!.image);
    setState(() {
      urlImage = url;
    });
  }

  backgroundGradient(double height) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color.fromARGB(255, 155, 165, 149),
            Color.fromARGB(255, 85, 87, 84),
          ],
          center: Alignment.center,
          radius: 0.5,
        ),
      ),
    );
  }

  profileTop(String image, String name) {
    return Row(
      children: [
        IconButton(
          icon: ClipRRect(
            borderRadius:
                BorderRadius.circular(10.0), // Adjust the radius as needed
            child: Image.network(image, width: 35, fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
              return LoadingAnimationWidget.beat(color: Colors.white, size: 40);
            }),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserProfilePage()));
          },
        ),
        Text(
          name,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }

  returnText(
    String text,
    FontWeight weight,
    double fontSize, {
    Color color = Colors.white,
    bool wrap = false,
  }) {
    return Text(
      text,
      softWrap: wrap,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: weight,
      ),
    );
  }

  returnLevel(String level, {bool collapse = false}) {
    double width = level.length * 30;

    if (collapse) {
      width = level.length * 20;
    }

    return Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent, // Sem preenchimento
                borderRadius: BorderRadius.circular(8.0), // Raio da borda
                border: Border.all(
                  color: Colors.amber, // Cor da borda
                  width: 2.0, // Largura da borda
                ),
              ),
              child: returnText(level, FontWeight.bold, !collapse ? 32 : 24,
                  color: Colors.amber),
            ),
            const Text(
              "Nível",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      clipBehavior: Clip.none,
      children: [
        // Gradiente de fundo
        backgroundGradient(widget.type == 1 ? 200 : 350),
        if (widget.type != 1)
          Positioned(
            right: 0,
            child: Container(
              alignment: Alignment.center,
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: Image.network(urlImage, fit: BoxFit.cover, errorBuilder:
                  (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                return Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: LoadingAnimationWidget.beat(
                      color: Colors.white, size: 40),
                );
              }),
            ),
          ),
        Positioned(
          child: Container(
            color: Colors.black26,
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    returnText("${_char?.name}", FontWeight.bold, 32),
                    Row(
                      spacing: 5,
                      children: [
                        returnText(
                            "${_char?.details?.classe}", FontWeight.w100, 24),
                        returnText('•', FontWeight.w100, 24),
                        returnText(
                            "${_char?.details?.race}", FontWeight.w100, 24),
                      ],
                    ),
                  ],
                ),
                returnLevel("${_char?.details?.level}"),
              ],
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: profileTop("${_user?.image}", "${_user?.name}"),
        ),
        // Imagem posicionada ao lado
      ],
    );
  }
}
