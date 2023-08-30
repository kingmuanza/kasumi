import 'package:flutter/material.dart';
import 'package:kasumi/models/participation.model.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class DisplayOrateur extends StatefulWidget {
  final Participation participation;
  const DisplayOrateur({
    super.key,
    required this.participation,
  });

  @override
  State<DisplayOrateur> createState() => _DisplayOrateurState();
}

class _DisplayOrateurState extends State<DisplayOrateur> {
  String formattedDate = "";
  Duration duree = Duration(seconds: 0);
  int _start = 0;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(widget.participation.debutParole);
    super.initState();
    _start = DateTime.now().difference(widget.participation.debutParole).inSeconds;
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      print(_start);
      _start++;
      duree = Duration(seconds: _start);
      setState(() {});
    });
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

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
              image: DecorationImage(
                image: NetworkImage(widget.participation.participant.utilisateur.photo),
                fit: BoxFit.cover,
              ),
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
              widget.participation.participant.utilisateur.nom,
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 0,
            ),
            child: Text(
              widget.participation.participant.role,
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
            child: Text(widget.participation.participant.role == "Modérateur".toUpperCase() ? "00:00" : _printDuration(duree)),
          ),
        ],
      ),
    );
  }
}
