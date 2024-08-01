import 'package:flutter/material.dart';

class TextBottomSheetComponent extends StatefulWidget {
  const TextBottomSheetComponent(
      {super.key, required this.textList, this.size = 150});

  final List<String> textList;
  final double size;

  @override
  _TextBottomSheetComponentState createState() =>
      _TextBottomSheetComponentState();
}

class _TextBottomSheetComponentState extends State<TextBottomSheetComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 30),
        height: widget.size,
        child: Column(
          children: widget.textList
              .map((text) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 300,
                        child: Text(
                          text,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ))
              .toList(),
        ));
  }
}
