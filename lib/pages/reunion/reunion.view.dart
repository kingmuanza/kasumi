import 'package:flutter/material.dart';
import 'package:kasumi/composants/display.temps.ecoulee.dart';
import 'package:kasumi/models/participant.model.dart';
import 'package:kasumi/models/participation.model.dart';
import 'package:kasumi/models/utilisateur.model.dart';
import 'package:kasumi/services/connexion.service.dart';
import 'package:kasumi/services/participation.service.dart';
import 'dart:async';
import 'package:intl/intl.dart';
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
  Participation? maParticipation;
  late Timer _timer;

  refresh() {
    Participant participant = Participant();
    participant.utilisateur = widget.reunion.utilisateur;
    participant.role = "Modérateur".toUpperCase();
    Participation participation = Participation(participant, widget.reunion);
    ParticipationService().getAllFromReunion(widget.reunion).then((resultats) {
      this.orateurs = [];
      orateurs.add(participation);
      participations = resultats;
      participations.forEach((p) {
        if (p.parle) {
          this.orateurs.add(p);
        }
        if (p.participant.utilisateur.id == ConnexionService.utilisateur!.id) {
          maParticipation = p;
        }
      });
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refresh();
    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      refresh();
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
                    if (ConnexionService.utilisateur!.id == widget.reunion.utilisateur.id) {
                      if (participation.participant.role != "Modérateur".toUpperCase()) {
                        if (orateurs.indexOf(participation) != -1) {
                          this.orateurs.remove(participation);
                          participation.parle = false;
                          participation.veutParler = false;
                          participation.finParole = DateTime.now();
                          participation.tempsDeParole += DateTime.now().difference(participation.debutParole).inSeconds;
                          ParticipationService().save(participation).then((value) {
                            setState(() {});
                          });
                        }
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
                    tileColor: maParticipation != null && maParticipation!.id == participation.id ? Colors.green.withOpacity(0.1) : Colors.white,
                    title: Text(
                      participation.participant.utilisateur.nom,
                      style: TextStyle(
                        fontWeight: maParticipation != null && maParticipation!.id == participation.id ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text("Temps de parole : ${_printDuration(duree)}"),
                    trailing: Icon(
                      Icons.mic,
                      color: participation.veutParler ? Colors.green : Colors.grey,
                    ),
                    onTap: () {
                      if (ConnexionService.utilisateur!.id == widget.reunion.utilisateur.id) {
                        if (orateurs.indexOf(participation) == -1) {
                          participation.veutParler = false;
                          participation.parle = true;
                          participation.debutParole = DateTime.now();
                          this.orateurs.add(participation);
                          ParticipationService().save(participation).then((value) {
                            setState(() {});
                          });
                        }
                      }
                    },
                  );
                }),
              ).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: ConnexionService.utilisateur!.id == widget.reunion.utilisateur.id
          ? Container(
              width: 0,
              height: 0,
            )
          : maParticipation != null && maParticipation!.parle
              ? Container(
                  width: 0,
                  height: 0,
                )
              : FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    print("Demander la parole");
                    if (!maParticipation!.veutParler) {
                      maParticipation!.veutParler = true;
                      maParticipation!.veutParlerDate = DateTime.now();
                      ParticipationService().save(maParticipation!).then((f) {
                        refresh();
                      });
                    }
                  },
                  child: Icon(Icons.mic),
                ),
    );
  }
}
