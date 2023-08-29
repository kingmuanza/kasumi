import 'package:flutter/material.dart';
import 'package:kasumi/models/reunion.model.dart';
import 'package:kasumi/pages/reunion/reunion.view.dart';

import 'pages/home.page.dart';

void main() {
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
        primaryColor: Colors.green,
      ),
      home: ReunionView(
        reunion: Reunion.create("Ma première réunion"),
      ),
    );
  }
}
