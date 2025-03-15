import 'package:CharVault/pages/landing_page.dart';
import 'package:CharVault/pages/user_profile_page.dart';
import 'package:CharVault/services/auth_service.dart';
import 'package:CharVault/styles/font.styles.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: LottieBuilder.asset(
                'assets/lottie/vault.json',
              ),
            ),
          ),
          Text(
            "Characters Vault",
            style: AppTextStyles.boldText(context,
                size: 32, color: Theme.of(context).colorScheme.onPrimary),
          )
        ],
      ),
      nextScreen: StreamBuilder<User?>(
          stream: AuthService.userStream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return snapshot.hasData
                    ? const UserProfilePage()
                    : const LandingPage();
              default:
                return const LandingPage();
            }
          }),
      centered: true,
      splashIconSize: 400,
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
