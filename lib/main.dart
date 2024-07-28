import 'package:character_vault/pages/initial_page.dart';
import 'package:character_vault/providers/login_provider.dart';
import 'package:character_vault/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
      home: const InitialPage(),
    );
  }
}
