import 'package:flutter/material.dart';
import 'dart:math';

import 'package:kasumi/models/reunion.model.dart';
import 'package:kasumi/pages/reunion/reunion.edit.code.dart';
import 'package:kasumi/services/connexion.service.dart';
import 'package:kasumi/services/reunion.service.dart';

class ReunionEdit extends StatefulWidget {
  const ReunionEdit({super.key});

  @override
  State<ReunionEdit> createState() => _ReunionEditState();
}

class _ReunionEditState extends State<ReunionEdit> {
  String nom = "";
  int randomNumber = 5780;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nouvelle réunion"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              onChanged: (value) {
                this.nom = value;
              },
              decoration: InputDecoration(
                label: Text("Nom de la réunion"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                color: Colors.green,
                child: TextButton(
                  onPressed: loading
                      ? null
                      : () {
                          loading = true;
                          setState(() {});
                          Random random = new Random();
                          randomNumber = random.nextInt(10000);
                          Reunion reunion = Reunion.create(nom);
                          reunion.code = "" + randomNumber.toString();
                          reunion.id = "" + randomNumber.toString();
                          reunion.utilisateur = ConnexionService.utilisateur!;
                          ReunionService().save(reunion).then((value) {
                            loading = false;
                            setState(() {});
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => ReunionEditCode(
                                  reunion: reunion,
                                ),
                              ),
                            );
                          });
                        },
                  child: Text(
                    "Créer la réunion",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            loading
                ? Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    width: 0,
                    height: 0,
                  ),
          ],
        ),
      ),
    );
  }
}
