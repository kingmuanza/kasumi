import 'package:flutter/material.dart';
import 'package:kasumi/models/reunion.model.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class TempsEcouleeReunion extends StatefulWidget {
  final Reunion reunion;
  const TempsEcouleeReunion({
    Key? key,
    required this.reunion,
  }) : super(key: key);

  @override
  State<TempsEcouleeReunion> createState() => _TempsEcouleeReunionState();
}

class _TempsEcouleeReunionState extends State<TempsEcouleeReunion> {
  String formattedDate = "";
  Duration duree = Duration(seconds: 0);
  int _start = 0;
  late Timer _timer;
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        _printDuration(duree),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
