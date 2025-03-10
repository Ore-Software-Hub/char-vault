import 'package:CharVault/components/button_component.dart';
import 'package:CharVault/components2/dropdown.component.dart';
import 'package:CharVault/components2/textfield.component.dart';
import 'package:CharVault/helpers/notification_helper.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:flutter/material.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _CreateCharacterPageState();
}

class _CreateCharacterPageState extends State<AddItemPage> {
  String name = "", value = "", tipo = "", quantity = "", description = "";

  @override
  void initState() {
    super.initState();
  }

  bool validateForm() {
    if (name.isEmpty) {
      NotificationHelper.showSnackBar(
        context,
        "Nome do item é obrigatório.",
      );
      return false;
    }
    if (tipo.isEmpty) {
      NotificationHelper.showSnackBar(
        context,
        "Tipo do item é obrigatório.",
      );
      return false;
    }
    if (description.isEmpty) {
      NotificationHelper.showSnackBar(
        context,
        "Descrição do item é obrigatório.",
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFieldComponent(
                label: 'Nome',
                onChanged: (value) => {
                      setState(() {
                        name = value;
                      })
                    },
                value: name),
            const SizedBox(
              height: 10,
            ),
            TextFieldComponent(
                label: "Dano / Bônus",
                hintText: "Dano da arma / Bônus de defesa",
                onChanged: (val) => {
                      setState(() {
                        value = val;
                      })
                    },
                value: value),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFieldComponent(
                      label: "Quantidade",
                      keyboardType: TextInputType.number,
                      onChanged: (value) => {
                            setState(() {
                              quantity = value;
                            })
                          },
                      value: quantity),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
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
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldComponent(
                value: description,
                label: "Descrição",
                maxlines: 20,
                onChanged: (value) => {
                      setState(() {
                        description = value;
                      })
                    })
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
              label: "Cancelar",
              pressed: () {
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            ButtonComponent(
              label: "Adicionar",
              pressed: () {
                if (validateForm()) {
                  var item = ItemModel(
                    id: '',
                    title: name,
                    value: value,
                    tipo: tipo,
                    quantity: quantity.isEmpty ? "1" : quantity,
                    description: description,
                  );
                  Navigator.pop(context, item);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
