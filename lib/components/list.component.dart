import 'package:CharVault/models/paper.model.dart';
import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter/material.dart';

class ListComponent extends StatefulWidget {
  const ListComponent({
    super.key,
    required this.list,
    this.title,
  });

  final String? title;
  final List<dynamic> list;

  @override
  State<ListComponent> createState() => _ListComponentState();
}

class _ListComponentState extends State<ListComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary),
                  child: Text(
                    widget.title!,
                    style: AppTextStyles.boldText(context,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
              ),
            ],
          ),
        if (widget.list is List<String>)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 4.0, // Espaçamento horizontal entre os widgets
              children: widget.list.map<Row>((text) {
                return Row(
                  spacing: 10,
                  children: [
                    Text(
                      '•',
                      style: AppTextStyles.boldText(context,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    Text(
                      text,
                      style: AppTextStyles.lightText(context,
                          size: 14,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        if (widget.list is List<PapersModel>)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: widget.list.map<Row>((paper) {
                return Row(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${paper.title}:",
                          style: AppTextStyles.boldText(context,
                              size: 14,
                              color: Theme.of(context).colorScheme.onSurface)),
                      Expanded(
                        child: Text(
                          paper.description,
                          style: AppTextStyles.italicText(context,
                              size: 14,
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                      )
                    ]);
              }).toList(),
            ),
          ),
      ],
    );
  }
}
