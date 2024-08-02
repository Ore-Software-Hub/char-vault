import 'package:CharVault/models/character_model.dart';
import 'package:CharVault/pages/initial_page.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharDetailsComponent extends StatefulWidget {
  const CharDetailsComponent({super.key, required this.char});

  final CharacterModel char;

  @override
  State<CharDetailsComponent> createState() => _CharDetailsComponentState();
}

class _CharDetailsComponentState extends State<CharDetailsComponent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<LoginProvider>(context, listen: false)
            .updateUser(char: widget.char);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const InitialPage()),
          (route) => false,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          height: 55,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary, // Sem preenchimento
            borderRadius: BorderRadius.circular(10.0), // Raio da borda
          ),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.network(
                  widget.char.image,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.char.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Nível ${widget.char.level}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
