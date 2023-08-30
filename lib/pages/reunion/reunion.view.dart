import 'package:flutter/material.dart';
import 'package:kasumi/composants/display.temps.ecoulee.dart';
import 'package:kasumi/models/utilisateur.model.dart';

import '../../composants/display.orateur.dart';
import '../../models/reunion.model.dart';

class ReunionView extends StatefulWidget {
  final Reunion reunion;
  const ReunionView({super.key, required this.reunion});

  @override
  State<ReunionView> createState() => _ReunionViewState();
}

class _ReunionViewState extends State<ReunionView> {
  List<Utilisateur> orateurs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orateurs.add(widget.reunion.utilisateur);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reunion.nom),
        backgroundColor: Colors.green,
        actions: [
          TempsEcouleeReunion(
            reunion: widget.reunion,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            color: Colors.grey.shade200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: orateurs.length,
              itemBuilder: (context, index) {
                Utilisateur utilisateur = orateurs[index];
                return DisplayOrateur(utilisateur: utilisateur);
              },
            ),
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(
                "Participants",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: ListTile.divideTiles(color: Colors.grey, tiles: [
                ListTile(
                  title: Text(
                    "Premier participant",
                  ),
                  subtitle: Text("Temps de parole : 00:00"),
                  trailing: Text("00:45"),
                ),
                ListTile(
                  title: Text(
                    "Second participant",
                  ),
                  subtitle: Text("Temps de parole : 00:00"),
                ),
              ]).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: Icon(Icons.mic),
      ),
    );
  }
}
