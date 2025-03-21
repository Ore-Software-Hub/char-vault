import 'package:CharVault/firebase_options.dart';
import 'package:CharVault/providers/login_provider.dart';
import 'package:CharVault/providers/theme_provider.dart';
import 'package:CharVault/splash_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    // androidProvider: AndroidProvider.playIntegrity,
    androidProvider: AndroidProvider.debug,
  );

  await _requestPermissions();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => LoginProvider()),
  ], child: const MyApp()));
}

Future<void> _requestPermissions() async {
  await [
    Permission.storage, // Para READ_EXTERNAL_STORAGE
    Permission.photos // Para READ_MEDIA_IMAGES
  ].request();
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
        home: const SplashScreen());
  }
}
