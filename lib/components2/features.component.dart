import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter/material.dart';

class FeaturesComponent extends StatefulWidget {
  const FeaturesComponent(
      {super.key,
      required this.title,
      required this.value,
      required this.modifier,
      required this.test});

  final String title;
  final String value;
  final String modifier;
  final String test;

  @override
  State<FeaturesComponent> createState() => _FeaturesComponentState();
}

class _FeaturesComponentState extends State<FeaturesComponent> {
  final con = FlipCardController();
  @override
  Widget build(BuildContext context) {
    var modifier = int.parse(widget.modifier);
    var textModifier = modifier > 0
        ? '+$modifier'
        : modifier < 0
            ? '$modifier'
            : modifier.toString();
    var test = int.parse(widget.test);
    var textTest = test > 0
        ? '+$test'
        : test < 0
            ? '$test'
            : test.toString();
    return FlipCard(
      rotateSide: RotateSide.top,
      onTapFlipping: true,
      axis: FlipAxis.vertical,
      controller: con,
      animationDuration: const Duration(milliseconds: 300),
      frontWidget: Column(
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
                  child: Text(
                    widget.value,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                    ),
                  ),
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
                  child: Column(
                    children: [
                      Text(
                        textModifier,
                        style: AppTextStyles.boldText(context),
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                      ),
                      Text(
                        widget.title,
                        style: AppTextStyles.lightText(context, size: 14),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      backWidget: Column(
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
                  child: Column(
                    children: [
                      Text(
                        'Resistência',
                        style: AppTextStyles.lightText(context, size: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        textTest,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                        ),
                      )
                    ],
                  ),
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
                  child: Column(
                    children: [
                      Text(
                        widget.value,
                        style: AppTextStyles.boldText(context),
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                      ),
                      Text(
                        widget.title,
                        style: AppTextStyles.lightText(context, size: 14),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
