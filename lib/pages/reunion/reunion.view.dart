import 'package:flutter/material.dart';

import '../../composants/display.orateur.dart';
import '../../models/reunion.model.dart';

class ReunionView extends StatefulWidget {
  final Reunion reunion;
  const ReunionView({super.key, required this.reunion});

  @override
  State<ReunionView> createState() => _ReunionViewState();
}

class _ReunionViewState extends State<ReunionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reunion.nom),
        backgroundColor: Colors.green,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "00:00:00",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
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
              itemCount: 3,
              itemBuilder: (context, index) {
                return DisplayOrateur();
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
