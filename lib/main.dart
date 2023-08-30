import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kasumi/models/reunion.model.dart';
import 'package:kasumi/pages/connexion.page.dart';
import 'package:kasumi/pages/reunion/reunion.view.dart';

import 'firebase_options.dart';
import 'pages/home.page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KASUMI',
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.green,
        ),
      ),
      home: ConnexionPage(),
    );
  }
}
