import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter/material.dart';

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
    var value = int.parse(widget.value);
    var textValue = value > 0
        ? '+$value'
        : value < 0
            ? '$value'
            : value.toString();
    return SizedBox(
      width: 90,
      child: Column(
        children: [
          Text(widget.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              style: AppTextStyles.lightText(context, size: 14)),
          Text(textValue, style: AppTextStyles.boldText(context)),
        ],
      ),
    );
  }
}
