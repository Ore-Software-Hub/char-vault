import 'package:CharVault/components/button_component.dart';
import 'package:flutter/material.dart';

class DialogComponent extends StatefulWidget {
  const DialogComponent({super.key, required this.message});
  final String message;
  @override
  _DialogComponentState createState() => _DialogComponentState();
}

class _DialogComponentState extends State<DialogComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmação'),
      content: Text(widget.message),
      actions: <Widget>[
        ButtonComponent(
          pressed: () {
            Navigator.of(context).pop(false); // Dismiss the dialog
          },
          label: "Não",
        ),
        ButtonComponent(
          pressed: () {
            Navigator.of(context).pop(true); // Dismiss the dialog
          },
          label: "Sim",
        ),
      ],
    );
  }
}
