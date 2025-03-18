import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/styles/font.styles.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter/material.dart';

class FeaturesComponent extends StatefulWidget {
  const FeaturesComponent({super.key, required this.feature});

  final FeatureDetails feature;

  @override
  State<FeaturesComponent> createState() => _FeaturesComponentState();
}

class _FeaturesComponentState extends State<FeaturesComponent> {
  final con = FlipCardController();

  String getSign(int? value) {
    if (value == null) return '';
    var sign = value >= 0 ? '+' : '';
    return '$sign$value';
  }

  @override
  Widget build(BuildContext context) {
    var feature = widget.feature;

    return FlipCard(
      rotateSide: RotateSide.top,
      onTapFlipping: feature.savingThrow != null ? true : false,
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
                    feature.value.toString(),
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
                        getSign(feature.savingThrow ?? feature.modifier!),
                        style: AppTextStyles.boldText(context,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                      ),
                      Text(
                        feature.title,
                        style: AppTextStyles.lightText(context,
                            size: 14,
                            color: Theme.of(context).colorScheme.onSurface),
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
                        style: AppTextStyles.lightText(context,
                            size: 12,
                            color: Theme.of(context).colorScheme.onSurface),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        getSign(feature.savingThrow),
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
                        '${feature.value}',
                        style: AppTextStyles.boldText(context,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                      ),
                      Text(
                        feature.title,
                        style: AppTextStyles.lightText(context,
                            size: 14,
                            color: Theme.of(context).colorScheme.onSurface),
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
