import 'package:CharVault/models/paper.model.dart';
import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter/material.dart';

class PapersBSComponent extends StatefulWidget {
  const PapersBSComponent({
    super.key,
    required this.paper,
  });

  final PapersModel paper;

  @override
  State<PapersBSComponent> createState() => _PapersBSComponentState();
}

class _PapersBSComponentState extends State<PapersBSComponent> {
  @override
  Widget build(BuildContext context) {
    String type = widget.paper.tipo == 'note'
        ? 'Anotação'
        : widget.paper.tipo == 'mission'
            ? 'Missão'
            : 'Relacionamento';

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/img/scroll_bg.png'), fit: BoxFit.cover),
        color: Color.fromARGB(255, 231, 216, 190),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Text(
            widget.paper.title,
            style: AppTextStyles.boldText(context, size: 28),
          ),
          Text(
            type,
            style: AppTextStyles.italicText(context),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            indent: 130,
            endIndent: 130,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.paper.description,
            style: AppTextStyles.lightText(context),
          ),
        ],
      ),
    );
  }
}
