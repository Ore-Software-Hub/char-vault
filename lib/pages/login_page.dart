import 'package:CharVault/components/button_component.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    // isUser = Provider.of<LoginProvider>(context, listen: false).userLogged;
    // if (isUser == null) {
    //   Navigator.pop(context);
    // }
    // loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, bottom: 50, left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Vamos jogar RPG?",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text("Escolha como fazer login abaixo"),
              Column(
                children: [
                  SizedBox(
                    child: ButtonComponent(
                        pressed: () {
                          
                        },
                        icon: PhosphorIconsBold.googleLogo,
                        label: "Entrar com Google",
                        tipo: 1,
                        color: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
