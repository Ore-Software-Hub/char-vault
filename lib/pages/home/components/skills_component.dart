import 'package:flutter/material.dart';

import 'package:character_vault/constants/cores.constants.dart' as cores;

class SkillsComponent extends StatefulWidget {
  const SkillsComponent({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  State<SkillsComponent> createState() => _SkillsComponentState();
}

class _SkillsComponentState extends State<SkillsComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Text(
            widget.value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const Divider(),
          Text(
            widget.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: false,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
