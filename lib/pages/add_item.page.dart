import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/components/dropdown.component.dart';
import 'package:CharVault/components/textfield.component.dart';
import 'package:CharVault/helpers/notification.helper.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:flutter/material.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key, this.type = 'all'});

  final String type;

  @override
  State<AddItemPage> createState() => _CreateCharacterPageState();
}

class _CreateCharacterPageState extends State<AddItemPage> {
  String name = "",
      value = "",
      tipo = "",
      quantity = "",
      description = "",
      title = "";

  List<ItemDropdown> types = [];

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case 'weapon':
        types = [
          ItemDropdown(display: "Arma", value: 0),
        ];
        title = tipo = 'Arma';

        break;
      case 'armor':
        types = [
          ItemDropdown(display: "Armadura", value: 0),
        ];
        title = tipo = 'Armadura';
        break;
      case 'magic':
        types = [
          ItemDropdown(display: "Magia", value: 0),
        ];
        title = tipo = 'Magia';
        break;
      default:
        types = [
          ItemDropdown(display: "Consumíveis", value: 0),
          ItemDropdown(display: "Equipamento", value: 0),
          ItemDropdown(display: "Item", value: 0),
          ItemDropdown(display: "Item mágico", value: 0),
          ItemDropdown(display: "Objeto", value: 0),
          ItemDropdown(display: "Outros", value: 0),
        ];
        title = "Item";
    }
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
        title: Text('Adicionar $title'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          spacing: 10,
          children: [
            TextFieldComponent(
                label: 'Nome',
                onChanged: (value) => {
                      setState(() {
                        name = value;
                      })
                    },
                value: name),
            if (widget.type != 'all')
              TextFieldComponent(
                  label: widget.type == 'armor' ? 'Defesa' : "Dados",
                  hintText: widget.type == 'armor'
                      ? "Bônus de defesa"
                      : widget.type == 'magic'
                          ? "Dados de dano / cura"
                          : 'Dados de dano',
                  onChanged: (val) => {
                        setState(() {
                          value = val;
                        })
                      },
                  value: value),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 8,
              children: [
                if (widget.type != 'magic' &&
                    widget.type != 'armor' &&
                    widget.type != 'weapon')
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
                Expanded(
                  child: DropdownComponent(
                    value: tipo,
                    onChanged: (value) {
                      setState(() {
                        tipo = value!;
                      });
                    },
                    hintText: "Tipo",
                    items: types,
                  ),
                )
              ],
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
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
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
                    quantity: quantity.isEmpty ? null : quantity,
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
