import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/user_model.dart';
import 'package:CharVault/pages/user_profile_page.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class HeaderComponent extends StatefulWidget {
  const HeaderComponent({super.key, this.type = 0});

  final int type;

  @override
  State<HeaderComponent> createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {
  UserModel? _user;
  CharacterModel? _char;

  @override
  void initState() {
    super.initState();
    _user = Provider.of<LoginProvider>(context, listen: false).userModel;
    loadChar();
  }

  loadChar() async {
    var char =
        Provider.of<LoginProvider>(context, listen: false).userModel!.char;
    setState(() => _char = char);
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
    debugPrint(_user.toString());
    return Row(
      children: [
        IconButton(
          icon: ClipRRect(
            borderRadius:
                BorderRadius.circular(10.0), // Adjust the radius as needed
            child: Image.network(image, width: 35, fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
              return const Text('😢');
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
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: weight,
      ),
    );
  }

  returnMoney(String po, String pp, String pb) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            children: [
              const PhosphorIcon(PhosphorIconsRegular.coin,
                  color: Colors.amber),
              returnText(po, FontWeight.w300, 16),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            children: [
              const PhosphorIcon(PhosphorIconsRegular.coin,
                  color: Colors.white70),
              returnText(pp, FontWeight.w300, 16),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            children: [
              const PhosphorIcon(PhosphorIconsRegular.coin,
                  color: Color.fromARGB(255, 189, 86, 49)),
              returnText(pb, FontWeight.w300, 16),
            ],
          ),
        ),
      ],
    );
  }

  returnLife(String cur, String max) {
    return Row(
      children: [
        const PhosphorIcon(
          PhosphorIconsRegular.heart,
          color: Colors.white,
          size: 24,
        ),
        returnText("$cur/", FontWeight.bold, 16),
        returnText(max, FontWeight.w100, 16),
      ],
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
    return widget.type == 0
        ? Stack(
            alignment: AlignmentDirectional.bottomEnd,
            clipBehavior: Clip.none,
            children: [
              // Gradiente de fundo
              backgroundGradient(350),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    returnText("${_char?.name}", FontWeight.bold, 32),
                    returnText("${_char?.classe}", FontWeight.w100, 24),
                    // returnLevel("${_char?.level}"),
                    returnLevel("${_char?.level}"),
                    returnLife("${_char?.curLife}", "${_char?.maxLife}"),
                    returnMoney("${_char?.po}", "${_char?.pb}", "${_char?.pp}")
                  ],
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  alignment: Alignment.centerRight,
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network("${_char?.image}", fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                    return const Text('😢');
                  }),
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: profileTop("${_user?.image}", "${_user?.name}"),
              ),
              // Imagem posicionada ao lado
            ],
          )
        : Stack(
            alignment: AlignmentDirectional.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              // Gradiente de fundo
              backgroundGradient(MediaQuery.of(context).size.height / 4),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            returnText("${_char?.name}", FontWeight.bold, 32),
                            returnText("${_char?.classe}", FontWeight.w100, 24),
                            Row(
                              children: [
                                returnLife(
                                    "${_char?.curLife}", "${_char?.maxLife}"),
                                const SizedBox(
                                  width: 20,
                                ),
                                returnMoney("${_char?.po}", "${_char?.pb}",
                                    "${_char?.pp}")
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        returnLevel("${_char?.level}", collapse: true),
                        // returnLevel("${_char?.level}"),
                      ],
                    ),
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
