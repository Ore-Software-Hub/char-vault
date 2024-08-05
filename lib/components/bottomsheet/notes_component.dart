import 'package:flutter/material.dart';
import 'package:CharVault/constants/cores.constants.dart' as cores;

class NotesBottomSheetComponent extends StatefulWidget {
  const NotesBottomSheetComponent({super.key, required this.note});

  final String note;

  @override
  _NotesBottomSheetComponentState createState() =>
      _NotesBottomSheetComponentState();
}

class _NotesBottomSheetComponentState extends State<NotesBottomSheetComponent> {
  TextEditingController _controller = TextEditingController();
  bool isEditingText = false;
  String note = "";
  double sheetSize = 400;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.note);
    note = widget.note;
  }

  Widget _editTitleTextField() {
    if (isEditingText) {
      return TextField(
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          border: UnderlineInputBorder(borderSide: BorderSide.none),
        ),
        onSubmitted: (newValue) {
          setState(() {
            note = newValue;
            isEditingText = false;
          });
        },
        autofocus: true,
        controller: _controller,
      );
    }
    return InkWell(
      onTap: () {
        setState(() {
          isEditingText = true;
        });
      },
      child: Text(
        note,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: MediaQuery.of(context)
            .viewInsets
            .bottom, // Ajusta o BottomSheet conforme o teclado
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: sheetSize,
        child: Column(
          children: [
            const Text(
              "Anotações",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: sheetSize - 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), // Raio da borda
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.primary, // Cor da borda
                    width: 1.0, // Largura da borda
                  ),
                ),
                child: _editTitleTextField()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(8)), // Torna o botão quadrado
                        ),
                      ),
                      overlayColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.pressed)) {
                            return cores
                                .secondaryColor; // Altere para a cor desejada
                          }
                          return null; // Use o valor padrão para outros estados
                        },
                      ),
                      foregroundColor:
                          const WidgetStatePropertyAll(cores.primaryColor),
                      backgroundColor:
                          const WidgetStatePropertyAll(Colors.white)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Voltar'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(8)), // Torna o botão quadrado
                        ),
                      ),
                      overlayColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.pressed)) {
                            return cores
                                .secondaryColor; // Altere para a cor desejada
                          }
                          return null; // Use o valor padrão para outros estados
                        },
                      ),
                      foregroundColor:
                          const WidgetStatePropertyAll(Colors.white),
                      backgroundColor:
                          const WidgetStatePropertyAll(cores.primaryColor)),
                  onPressed: () {
                    Navigator.pop(context, note);
                  },
                  child: const Text('Salvar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
