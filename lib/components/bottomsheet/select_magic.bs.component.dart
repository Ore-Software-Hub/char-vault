import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/components/card.component.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SelectMagicBSComponent extends StatefulWidget {
  const SelectMagicBSComponent({
    super.key,
    required this.list,
  });

  final List<ItemModel> list;

  @override
  State<SelectMagicBSComponent> createState() => _SelectMagicBSComponentState();
}

class _SelectMagicBSComponentState extends State<SelectMagicBSComponent> {
  ItemModel? selected;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context)
            .viewInsets
            .bottom, // Ajusta altura para teclado
      ),
      child: SingleChildScrollView(
        // Permite rolagem se necessário
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Usa apenas o espaço necessário
            children: [
              Text(
                "Selecionar Magia",
                style: AppTextStyles.boldText(context,
                    size: 20, color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 10),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                spacing: 4.0, // Espaçamento horizontal entre os widgets
                runSpacing: 8.0, // Espaçamento vertical entre as linhas
                children: List.generate(widget.list.length, (index) {
                  return CardComponent(
                    top: InkWell(
                      onTap: () async {
                        setState(() {
                          selected = widget.list[index];
                        });
                      },
                      child: Text(
                        widget.list[index].title,
                        style: AppTextStyles.boldText(
                          context,
                          color: Theme.of(context).colorScheme.primary,
                          size: 18,
                        ),
                      ),
                    ),
                    bottom: Text(
                      selected?.id == widget.list[index].id
                          ? 'Selecionado'
                          : 'Magia',
                      style: AppTextStyles.lightText(context,
                          size: 12,
                          color: selected?.id == widget.list[index].id
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonComponent(
                    pressed: () => Navigator.pop(context),
                    label: "Cancelar",
                    tipo: 1,
                    icon: PhosphorIconsBold.x,
                  ),
                  const SizedBox(width: 10),
                  ButtonComponent(
                    pressed: () => {Navigator.pop(context, selected)},
                    label: "Salvar",
                    tipo: 1,
                    icon: PhosphorIconsBold.floppyDisk,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
