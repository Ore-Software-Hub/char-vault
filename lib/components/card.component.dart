import 'package:flutter/material.dart';

class CardComponent extends StatefulWidget {
  const CardComponent({
    super.key,
    required this.top,
    required this.bottom,
  });

  final Widget top;
  final Widget bottom;

  @override
  State<CardComponent> createState() => _CardComponentState();
}

class _CardComponentState extends State<CardComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Container(
                width: 90,
                height: 90,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.onSurface),
                    color: Theme.of(context).colorScheme.tertiary),
                alignment: Alignment.center,
                child: widget.top,
              ),
              Container(
                width: 90,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  border: Border(
                    left: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface),
                    right: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface),
                    bottom: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
                alignment: Alignment.center,
                child: widget.bottom,
              )
            ],
          ),
        )
      ],
    );
  }
}
