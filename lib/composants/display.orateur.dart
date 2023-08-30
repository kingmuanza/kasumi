import 'package:flutter/material.dart';
import 'package:kasumi/models/utilisateur.model.dart';

class DisplayOrateur extends StatefulWidget {
  final Utilisateur utilisateur;
  const DisplayOrateur({
    super.key,
    required this.utilisateur,
  });

  @override
  State<DisplayOrateur> createState() => _DisplayOrateurState();
}

class _DisplayOrateurState extends State<DisplayOrateur> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 100,
      margin: EdgeInsets.only(
        right: 20,
        left: 20,
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.only(
              top: 20,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: Text(
              widget.utilisateur.nom,
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 0,
            ),
            child: Text(
              "Modérateur",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 0,
            ),
            child: Text("00:00"),
          ),
        ],
      ),
    );
  }
}
