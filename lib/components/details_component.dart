import 'package:flutter/material.dart';

class DetailsComponent extends StatefulWidget {
  const DetailsComponent({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  State<DetailsComponent> createState() => _DetailsComponentState();
}

class _DetailsComponentState extends State<DetailsComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4 - 10,
      child: Column(
        children: [
          Text(
            widget.value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
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
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
