import 'package:CharVault/components/button_component.dart';
import 'package:CharVault/components/dropdown_component.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:CharVault/constants/cores.constants.dart' as cores;

class AddItemBottomSheetComponent extends StatefulWidget {
  const AddItemBottomSheetComponent(
      {super.key, required this.editing, this.item});
  final bool editing;
  final ItemModel? item;

  @override
  _AddItemBottomSheetComponentState createState() =>
      _AddItemBottomSheetComponentState();
}

class _AddItemBottomSheetComponentState
    extends State<AddItemBottomSheetComponent> {
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerValue = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();

  double sheetSize = 350;
  String title = "";
  String action = "Valor";
  String tipo = "";

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerValue.dispose();
    _controllerDescription.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controllerTitle =
        TextEditingController(text: widget.editing ? widget.item!.title : null);
    _controllerValue =
        TextEditingController(text: widget.editing ? widget.item!.value : null);
    _controllerDescription = TextEditingController(
        text: widget.editing ? widget.item!.description : null);
    title = widget.editing ? "Editando Item" : "Adicionando Item";
    tipo = widget.editing ? widget.item!.tipo : "";
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
                decoration: textFieldDecoration("Nome do Item"),
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
                    decoration: textFieldDecoration(action),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  child: DropdownComponent(
                    value: tipo,
                    onChanged: (value) {
                      setState(() {
                        tipo = value!;
                      });
                    },
                    hintText: "Tipo",
                    items: [
                      ItemDropdown(display: "Arma", value: 0),
                      ItemDropdown(display: "Armadura", value: 0),
                      ItemDropdown(display: "Consumíveis", value: 0),
                      ItemDropdown(display: "Equipamento", value: 0),
                      ItemDropdown(display: "Item", value: 0),
                      ItemDropdown(display: "Item mágico", value: 0),
                      ItemDropdown(display: "Magia", value: 0),
                      ItemDropdown(display: "Objeto", value: 0),
                      ItemDropdown(display: "Outros", value: 0),
                    ],
                    foregroundColor: Colors.white,
                    backgroundColor: cores.secondaryColor,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                maxLines: 3,
                controller: _controllerDescription,
                style: const TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                decoration: textFieldDecoration("Descrição"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonComponent(
                  pressed: () {
                    Navigator.pop(context, null);
                  },
                  label: 'Voltar',
                ),
                ButtonComponent(
                  pressed: () {
                    var newItemModel = ItemModel(
                        widget.editing ? widget.item!.id : "",
                        _controllerTitle.text,
                        _controllerValue.text,
                        _controllerDescription.text,
                        tipo);
                    Navigator.pop(context, newItemModel);
                  },
                  disabled: _controllerTitle.text.isEmpty ||
                      _controllerValue.text.isEmpty ||
                      _controllerDescription.text.isEmpty,
                  label: 'Salvar',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
