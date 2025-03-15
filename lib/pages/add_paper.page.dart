import 'package:CharVault/components/button.component.dart';
import 'package:CharVault/components/textfield.component.dart';
import 'package:CharVault/helpers/notification.helper.dart';
import 'package:flutter/material.dart';

class AddPaperPage extends StatefulWidget {
  const AddPaperPage(
      {super.key,
      required this.title,
      this.body = false,
      this.keyboardType = 'String'});

  final String title;
  final String keyboardType;
  final bool body;

  @override
  State<AddPaperPage> createState() => _CreateCharacterPageState();
}

class _CreateCharacterPageState extends State<AddPaperPage> {
  String _title = "";
  String _body = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar ${widget.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFieldComponent(
                label: widget.title,
                onChanged: (value) => {
                      setState(() {
                        _title = value;
                      })
                    },
                value: _title),
            const SizedBox(
              height: 10,
            ),
            if (widget.body)
              TextFieldComponent(
                  label: 'Descrição',
                  maxlines: widget.keyboardType == 'String' ? 20 : null,
                  keyboardType: widget.keyboardType == 'String'
                      ? TextInputType.text
                      : TextInputType.number,
                  onChanged: (value) => {
                        setState(() {
                          _body = value;
                        })
                      },
                  value: _body),
          ],
        )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),
        child: Row(
          children: [
            ButtonComponent(
              label: "Cancelar",
              pressed: () {
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            ButtonComponent(
              label: "Adicionar",
              pressed: () {
                if (_title.isEmpty || (widget.body && _body.isEmpty)) {
                  NotificationHelper.showSnackBar(context,
                      "Informe ${widget.title}${widget.body ? ' e ${widget.body}' : ''}",
                      level: 2);
                } else {
                  Navigator.pop(context, [_title, _body]);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
