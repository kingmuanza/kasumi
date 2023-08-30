import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

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
  String formattedDate = "";
  Duration duree = Duration(seconds: 0);
  int _start = 0;
  @override
  void initState() {
    // TODO: implement initState
    formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(widget.reunion.debut);
    super.initState();
    _start = DateTime.now().difference(widget.reunion.debut).inSeconds;
    Timer _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
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
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => ReunionView(
                reunion: widget.reunion,
              ),
            ),
          );
        },
      ),
    );
  }
}
