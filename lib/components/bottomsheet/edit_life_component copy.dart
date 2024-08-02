import 'package:CharVault/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:CharVault/constants/cores.constants.dart' as cores;
import 'package:provider/provider.dart';

class EditLifeBottomSheetComponent extends StatefulWidget {
  const EditLifeBottomSheetComponent({super.key, required this.curLife});
  final String curLife;

  @override
  _EditLifeBottomSheetComponentState createState() =>
      _EditLifeBottomSheetComponentState();
}

class _EditLifeBottomSheetComponentState
    extends State<EditLifeBottomSheetComponent> {
  TextEditingController _controllerCurLife = TextEditingController();
  TextEditingController _controllerNewLife = TextEditingController();

  double sheetSize = 250;

  @override
  void dispose() {
    _controllerCurLife.dispose();
    _controllerNewLife.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controllerCurLife = TextEditingController(text: widget.curLife);
    _controllerNewLife = TextEditingController();
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
              "Atualizar Vida",
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
                readOnly: true,
                controller: _controllerCurLife,
                style: const TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                decoration: textFieldDecoration("Vida atual"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _controllerNewLife,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                decoration: textFieldDecoration("Novo valor"),
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
                  onPressed: _controllerNewLife.text.isEmpty
                      ? null
                      : () {
                          var life = _controllerNewLife.text;

                          Navigator.pop(context, life);
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
