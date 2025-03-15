import 'package:CharVault/components/button_component.dart';
import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/models/item_model.dart';
import 'package:CharVault/models/paper.model.dart';
import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SectionComponent extends StatefulWidget {
  const SectionComponent({
    super.key,
    required this.title,
    required this.list,
    required this.buttonAdd,
    this.pressed,
  });

  final String title;
  final List<dynamic> list;
  final Widget buttonAdd;
  final Function(int index)? pressed;

  @override
  State<SectionComponent> createState() => _SectionComponentState();
}

class _SectionComponentState extends State<SectionComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            widget.buttonAdd
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        if (widget.list.isEmpty)
          Row(
            children: [
              PhosphorIcon(
                PhosphorIconsBold.placeholder,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nenhum item adicionado",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Adicione um novo!",
                  )
                ],
              )
            ],
          ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 4.0, // Espaçamento horizontal entre os widgets
          runSpacing: 4.0, // Espaçamento vertical entre as linhas
          children: widget.list.asMap().entries.map<Row>((entry) {
            int index = entry.key;
            var item = entry.value;

            if (item is PapersModel) {
              return Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        widget.pressed!(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              item.description,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ButtonComponent(
                    pressed: () => {
                      setState(() {
                        widget.list.remove(item);
                      })
                    },
                    tipo: 0,
                    icon: PhosphorIconsBold.minus,
                  )
                ],
              );
            }
            if (item is String) {
              return Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        widget.pressed!(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.all(8),
                        child: Text(
                          item,
                          style: AppTextStyles.lightText(context),
                        ),
                      ),
                    ),
                  ),
                  ButtonComponent(
                    pressed: () => {
                      setState(() {
                        widget.list.remove(item);
                      })
                    },
                    tipo: 0,
                    icon: PhosphorIconsBold.minus,
                  )
                ],
              );
            }
            if (item is Currency) {
              return Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        widget.pressed!(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.type,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              item.amount.toString(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ButtonComponent(
                    pressed: () => {
                      setState(() {
                        widget.list.remove(item);
                      })
                    },
                    tipo: 0,
                    icon: PhosphorIconsBold.minus,
                  )
                ],
              );
            }
            if (item is ItemModel) {
              return Row(
                children: [
                  if (item.quantity.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.all(8),
                      child: Text("${item.quantity}x"),
                    ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      widget.pressed!(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.all(8),
                      child: Text(item.title),
                    ),
                  )),
                  const SizedBox(
                    width: 5,
                  ),
                  if (item.value.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.all(8),
                      child: Text(item.value),
                    ),
                  ButtonComponent(
                    pressed: () => {
                      setState(() {
                        widget.list.remove(item);
                      })
                    },
                    tipo: 0,
                    icon: PhosphorIconsBold.minus,
                  )
                ],
              );
            }
            return Row();
          }).toList(),
        )
      ],
    );
  }
}
