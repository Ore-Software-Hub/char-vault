import 'package:CharVault/models/character_model.dart';
import 'package:flutter/material.dart';
import 'package:CharVault/constants/cores.constants.dart' as cores;

class EditMoneyBottomSheetComponent extends StatefulWidget {
  const EditMoneyBottomSheetComponent({super.key, required this.char});
  final CharacterModel char;

  @override
  _EditMoneyBottomSheetComponentState createState() =>
      _EditMoneyBottomSheetComponentState();
}

class _EditMoneyBottomSheetComponentState
    extends State<EditMoneyBottomSheetComponent> {
  TextEditingController _controllerGold = TextEditingController();
  TextEditingController _controllerSilver = TextEditingController();
  TextEditingController _controllerBronze = TextEditingController();

  double sheetSize = 350;

  @override
  void dispose() {
    _controllerGold.dispose();
    _controllerSilver.dispose();
    _controllerBronze.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controllerGold = TextEditingController(text: widget.char.po);
    _controllerSilver = TextEditingController(text: widget.char.pp);
    _controllerBronze = TextEditingController(text: widget.char.pb);
  }

  textFieldDecoration(String title) {
    return InputDecoration(
      labelText: title,
      labelStyle:
          const TextStyle(color: Colors.white), // Cor do rótulo do TextField
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.white, // Cor da borda
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.white, // Cor da borda quando habilitado
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.white, // Cor da borda quando focado
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: MediaQuery.of(context)
            .viewInsets
            .bottom, // Ajusta o BottomSheet conforme o teclado
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: sheetSize,
        child: Column(
          children: [
            const Text(
              "Atualizar Dinheiro",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _controllerGold,
                style: const TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                decoration: textFieldDecoration("Moedas de Ouro"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _controllerSilver,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                decoration: textFieldDecoration("Moedas de Prata"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _controllerBronze,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                decoration: textFieldDecoration("Moedas de Bronze"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(8)), // Torna o botão quadrado
                        ),
                      ),
                      overlayColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.pressed)) {
                            return cores
                                .secondaryColor; // Altere para a cor desejada
                          }
                          return null; // Use o valor padrão para outros estados
                        },
                      ),
                      foregroundColor:
                          const WidgetStatePropertyAll(cores.primaryColor),
                      backgroundColor:
                          const WidgetStatePropertyAll(Colors.white)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Voltar'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(8)), // Torna o botão quadrado
                        ),
                      ),
                      overlayColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.pressed)) {
                            return cores
                                .secondaryColor; // Altere para a cor desejada
                          }
                          return null; // Use o valor padrão para outros estados
                        },
                      ),
                      foregroundColor:
                          const WidgetStatePropertyAll(Colors.white),
                      backgroundColor:
                          const WidgetStatePropertyAll(cores.primaryColor)),
                  onPressed: () {
                    Navigator.pop(context,);
                  },
                  child: const Text('Salvar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
