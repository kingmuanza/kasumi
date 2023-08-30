import 'package:flutter/material.dart';
import 'package:kasumi/models/reunion.model.dart';
import 'package:kasumi/pages/home.page.dart';

class ReunionEditCode extends StatefulWidget {
  final Reunion reunion;
  const ReunionEditCode({super.key, required this.reunion});

  @override
  State<ReunionEditCode> createState() => _ReunionEditCodeState();
}

class _ReunionEditCodeState extends State<ReunionEditCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reunion.nom),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: Text(
              "Votre réunion a bien éte créée !",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: Text(
              "Un code a été créé pour accéder à la réunion. Veuillez le communiquer à tous les participants",
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: Text(
              widget.reunion.code,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              color: Colors.green,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => MyHomePage(),
                    ),
                  );
                },
                child: Text(
                  "Revenir à l'accueil",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
