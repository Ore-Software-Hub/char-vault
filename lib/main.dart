import 'package:CharVault/firebase_options.dart';
import 'package:CharVault/pages/initial_page.dart';
import 'package:CharVault/pages/landing_page.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:CharVault/providers/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => LoginProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('en'), Locale('pt-BR')],
      debugShowCheckedModeBanner: false,
      title: 'Character Vault',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const LandingPage(),
    );
  }
}
