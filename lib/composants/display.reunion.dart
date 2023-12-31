import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:kasumi/models/participant.model.dart';
import 'package:kasumi/models/participation.model.dart';
import 'package:kasumi/services/connexion.service.dart';
import 'package:kasumi/services/participation.service.dart';

import '../models/reunion.model.dart';
import '../pages/reunion/reunion.view.dart';

class DisplayReunion extends StatefulWidget {
  const DisplayReunion({
    Key? key,
    required this.reunion,
  });
  final Reunion reunion;

  @override
  State<DisplayReunion> createState() => _DisplayReunionState();
}

class _DisplayReunionState extends State<DisplayReunion> {
  TextEditingController codeCtrl = TextEditingController();
  String formattedDate = "";
  Duration duree = Duration(seconds: 0);
  int _start = 0;
  late Timer _timer;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(widget.reunion.debut);
    super.initState();
    _start = DateTime.now().difference(widget.reunion.debut).inSeconds;
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

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        if (codeCtrl.text == widget.reunion.code) {
          Participant participant = Participant();
          participant.utilisateur = ConnexionService.utilisateur!;
          participant.role = "PARTICIPANT";
          participant.tempsDeParole = 0;
          Participation participation = Participation(participant, widget.reunion);
          ParticipationService().save(participation).then((value) {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ReunionView(
                  reunion: widget.reunion,
                ),
              ),
            );
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("le code est incorrect"),
          ));
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Code de la réunion"),
      content: TextFormField(controller: codeCtrl),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: ListTile(
        title: Text(
          widget.reunion.nom,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(formattedDate),
        leading: Icon(
          Icons.timer,
          color: Colors.green,
        ),
        trailing: Text(_printDuration(duree)),
        onTap: () {
          if (ConnexionService.utilisateur!.id == widget.reunion.utilisateur.id) {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ReunionView(
                  reunion: widget.reunion,
                ),
              ),
            );
          } else {
            String id = widget.reunion.id + "--" + ConnexionService.utilisateur!.id;
            ParticipationService().getOne(id).then((value) {
              if (value != null) {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ReunionView(
                      reunion: widget.reunion,
                    ),
                  ),
                );
              } else {
                showAlertDialog(context);
              }
            });
          }
        },
      ),
    );
  }
}
