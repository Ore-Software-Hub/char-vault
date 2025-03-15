import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter/material.dart';

class LineComponent extends StatefulWidget {
  const LineComponent({
    super.key,
    required this.title,
    required this.value,
    this.line = false,
    this.valueString = false,
  });

  final String title;
  final String value;
  final bool line;
  final bool valueString;

  @override
  State<LineComponent> createState() => _LineComponentState();
}

class _LineComponentState extends State<LineComponent> {
  @override
  Widget build(BuildContext context) {
    var textValue = widget.value;
    if (!widget.valueString) {
      try {
        var value = int.parse(widget.value);
        textValue = value > 0
            ? '+$value'
            : value < 0
                ? '$value'
                : value.toString();
      } catch (e) {
        textValue = widget.value;
      }
    }
    return SizedBox(
      width: 75,
      child: Column(
        children: [
          Text(widget.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              style: AppTextStyles.lightText(context, size: 10)),
          Text(textValue, style: AppTextStyles.boldText(context, size: 14)),
          if (widget.line) const Divider(),
        ],
      ),
    );
  }
}
