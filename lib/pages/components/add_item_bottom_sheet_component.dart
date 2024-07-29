import 'package:character_vault/pages/components/dropdown_component.dart';
import 'package:flutter/material.dart';
import 'package:character_vault/constants/cores.constants.dart' as cores;

class AddItemBottomSheetComponent extends StatefulWidget {
  const AddItemBottomSheetComponent({super.key, required this.tipo});

  final int tipo;

  @override
  _AddItemBottomSheetComponentState createState() =>
      _AddItemBottomSheetComponentState();
}

class _AddItemBottomSheetComponentState
    extends State<AddItemBottomSheetComponent> {
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerValue = TextEditingController();

  double sheetSize = 250;
  String title = "";
  String action = "";

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerValue.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controllerTitle = TextEditingController();
    _controllerValue = TextEditingController();
    switch (widget.tipo) {
      case 0:
        title = "Adicionar um Equipamento";
        action = "Valor";
        break;
      case 1:
        title = "Adicionar um Objeto";
        action = "Valor";
        break;
      case 2:
        title = "Adicionar uma Arma";
        action = "Valor";
        break;
      case 3:
        title = "Adicionar uma Magia";
        action = "Valor";
        break;
    }
  }

  _TextFieldDecoration(String title) {
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

  onChangeSelect(String selected) {}

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
            Text(
              title,
              style: const TextStyle(
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
                controller: _controllerTitle,
                style: const TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                decoration: _TextFieldDecoration("Nome do Item"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  child: TextField(
                    controller: _controllerValue,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    cursorColor: Colors.white,
                    decoration: _TextFieldDecoration(action),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  child: DropdownComponent(
                    onChanged: (value) {},
                    hintText: "",
                  ),
                )
              ],
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
                    Navigator.pop(context);
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
