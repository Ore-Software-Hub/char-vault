import 'package:CharVault/components/button_component.dart';
import 'package:CharVault/helpers/notification_helper.dart';
import 'package:CharVault/pages/user_profile_page.dart';
import 'package:CharVault/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  loginWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await AuthService.signInWithGoogle();
      setState(() {
        _isLoading = false;
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const UserProfilePage()),
        (route) => false,
      );
    } catch (err) {
      if (!context.mounted) return;
      NotificationHelper.showSnackBar(context, "Error $err", level: 2);
      setState(() {
        _isLoading = false;
      });
    }
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
                          loginWithGoogle();
                        },
                        icon: PhosphorIconsBold.googleLogo,
                        label: "Entrar com Google",
                        tipo: 1,
                        loading: _isLoading,
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
