import 'package:flutter/material.dart';
import 'package:kasumi/composants/display.temps.ecoulee.dart';
import 'package:kasumi/models/participant.model.dart';
import 'package:kasumi/models/participation.model.dart';
import 'package:kasumi/models/utilisateur.model.dart';
import 'package:kasumi/services/participation.service.dart';

import '../../composants/display.orateur.dart';
import '../../models/reunion.model.dart';

class ReunionView extends StatefulWidget {
  final Reunion reunion;
  const ReunionView({super.key, required this.reunion});

  @override
  State<ReunionView> createState() => _ReunionViewState();
}

class _ReunionViewState extends State<ReunionView> {
  List<Participation> orateurs = [];
  List<Participation> participations = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Participant participant = Participant();
    participant.utilisateur = widget.reunion.utilisateur;
    participant.role = "Modérateur".toUpperCase();
    Participation participation = Participation(participant, widget.reunion);
    orateurs.add(participation);
    ParticipationService().getAllFromReunion(widget.reunion).then((resultats) {
      participations = resultats;
      participations.forEach((p) {
        if (p.parle) {
          this.orateurs.add(p);
        }
      });
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
                Participation participation = orateurs[index];
                return InkWell(
                  child: DisplayOrateur(participation: participation),
                  onTap: () {
                    if (participation.participant.role != "Modérateur".toUpperCase()) {
                      if (orateurs.indexOf(participation) != -1) {
                        this.orateurs.remove(participation);
                        participation.parle = false;
                        participation.finParole = DateTime.now();
                        participation.tempsDeParole = DateTime.now().difference(participation.debutParole).inSeconds;
                        ParticipationService().save(participation).then((value) {
                          setState(() {});
                        });
                      }
                    }
                  },
                );
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
              children: ListTile.divideTiles(
                color: Colors.grey,
                tiles: List.generate(participations.length, (index) {
                  Participation participation = participations[index];
                  Duration duree = Duration(seconds: participation.tempsDeParole);
                  return ListTile(
                    title: Text(
                      participation.participant.utilisateur.nom,
                    ),
                    subtitle: Text("Temps de parole : ${_printDuration(duree)}"),
                    trailing: Icon(
                      Icons.mic,
                      color: Colors.green,
                    ),
                    onTap: () {
                      if (orateurs.indexOf(participation) == -1) {
                        participation.parle = true;
                        participation.debutParole = DateTime.now();
                        this.orateurs.add(participation);
                        ParticipationService().save(participation).then((value) {
                          setState(() {});
                        });
                      }
                    },
                  );
                }),
              ).toList(),
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
