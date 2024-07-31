import 'package:flutter/material.dart';

import 'package:CharVault/constants/cores.constants.dart' as cores;

class FeaturesComponent extends StatefulWidget {
  const FeaturesComponent(
      {super.key,
      required this.title,
      required this.value,
      required this.modifier});

  final String title;
  final String value;
  final String modifier;

  @override
  State<FeaturesComponent> createState() => _FeaturesComponentState();
}

class _FeaturesComponentState extends State<FeaturesComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 65,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: cores.gray,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
              Text(
                widget.value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Container(
                width: 65,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: cores.primaryColor, // Sem preenchimento
                  borderRadius: BorderRadius.circular(8.0), // Raio da borda
                ),
                child: Text(
                  widget.modifier,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
