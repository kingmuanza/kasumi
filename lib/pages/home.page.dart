import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kasumi/models/reunion.model.dart';
import 'package:kasumi/pages/reunion/reunion.edit.dart';
import 'package:kasumi/pages/reunion/reunion.view.dart';
import 'package:kasumi/services/connexion.service.dart';
import 'package:kasumi/services/reunion.service.dart';
import 'package:intl/intl.dart';

import '../composants/display.reunion.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Reunion> reunions = [];
  DateTime datetime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReunionService().getAll().then((values) {
      reunions = values;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: 250,
              padding: EdgeInsets.only(top: 50),
              color: Colors.grey.shade200,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(ConnexionService.utilisateur!.photo),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(ConnexionService.utilisateur!.nom),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(ConnexionService.utilisateur!.login),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Accueil"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: reunions.length,
        itemBuilder: (context, index) {
          Reunion reunion = reunions[index];

          return DisplayReunion(reunion: reunion);
        },
      ),
      floatingActionButton: ConnexionService.utilisateur!.role == "ADMIN"
          ? FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ReunionEdit(),
                  ),
                );
              },
              child: Icon(Icons.add),
            )
          : Container(
              width: 0,
              height: 0,
            ),
    );
  }
}
