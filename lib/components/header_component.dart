import 'package:CharVault/pages/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HeaderComponent extends StatefulWidget {
  const HeaderComponent({super.key, required this.user, this.type = 0});

  final dynamic user;
  final int type;

  @override
  State<HeaderComponent> createState() => _HeaderComponentState();
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

profileTop(BuildContext context, String image, String name) {
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserProfilePage()));
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
            const PhosphorIcon(PhosphorIconsRegular.coin, color: Colors.amber),
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
      returnText(cur, FontWeight.bold, 16),
      returnText(max, FontWeight.w100, 16),
    ],
  );
}

returnLevel(String level) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 30,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.transparent, // Sem preenchimento
            borderRadius: BorderRadius.circular(8.0), // Raio da borda
            border: Border.all(
              color: Colors.amber, // Cor da borda
              width: 2.0, // Largura da borda
            ),
          ),
          child: returnText(level, FontWeight.bold, 32, color: Colors.amber),
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
    ),
  );
}

class _HeaderComponentState extends State<HeaderComponent> {
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
                    returnText(
                        "${widget.user?.char.name}", FontWeight.bold, 32),
                    returnText(
                        "${widget.user?.char.clase}", FontWeight.w100, 24),
                    returnLevel("${widget.user?.char.level}"),
                    returnLife("${widget.user?.char.curLife}",
                        "${widget.user?.char.maxLife}"),
                    returnMoney("${widget.user?.char.po}",
                        "${widget.user?.char.pb}", "${widget.user?.char.pp}")
                  ],
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  alignment: Alignment.centerRight,
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network("${widget.user?.char.image}",
                      width: 35,
                      fit: BoxFit.cover, errorBuilder: (BuildContext context,
                          Object exception, StackTrace? stackTrace) {
                    return const Text('😢');
                  }),
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: profileTop(
                    context, "${widget.user?.image}", "${widget.user?.name}"),
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
                            returnText("${widget.user?.char.name}",
                                FontWeight.bold, 32),
                            returnText("${widget.user?.char.clase}",
                                FontWeight.w100, 24),
                            Row(
                              children: [
                                returnLife("${widget.user?.char.curLife}",
                                    "${widget.user?.char.maxLife}"),
                                const SizedBox(
                                  width: 20,
                                ),
                                returnMoney(
                                    "${widget.user?.char.po}",
                                    "${widget.user?.char.pb}",
                                    "${widget.user?.char.pp}")
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        returnLevel("${widget.user?.char.level}"),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: profileTop(
                    context, "${widget.user?.image}", "${widget.user?.name}"),
              ),
              // Imagem posicionada ao lado
            ],
          );
  }
}
