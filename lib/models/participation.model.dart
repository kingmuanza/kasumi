import 'package:kasumi/models/participant.model.dart';
import 'package:kasumi/models/reunion.model.dart';

class Participation {
  String id = "";
  Participant participant = Participant();
  Reunion reunion = Reunion();
  DateTime arrivee = DateTime.now();
  DateTime debutParole = DateTime.now();
  DateTime finParole = DateTime.now();
  int tempsDeParole = 0;
  bool parle = false;
  bool veutParler = false;
  DateTime veutParlerDate = DateTime.now();

  Participation(Participant p, Reunion r) {
    participant = p;
    reunion = r;
    id = reunion.id + "--" + participant.utilisateur.id;
  }

  Participation.fromJSON(Map<String, dynamic> json) {
    print("Reunion.fromJSON");
    id = json["id"];
    parle = json["parle"] ?? false;
    veutParler = json["veutParler"] ?? false;
    participant = json["participant"] != null ? Participant.fromJSON(json["participant"]) : Participant();
    reunion = json["reunion"] != null ? Reunion.fromJSON(json["reunion"]) : Reunion();
    tempsDeParole = json["tempsDeParole"] ?? 0;
    arrivee = json["arrivee"] != null ? DateTime.parse(json["arrivee"]) : DateTime.now();
    debutParole = json["debutParole"] != null ? DateTime.parse(json["debutParole"]) : DateTime.now();
    finParole = json["finParole"] != null ? DateTime.parse(json["finParole"]) : DateTime.now();
    veutParlerDate = json["veutParlerDate"] != null ? DateTime.parse(json["veutParlerDate"]) : DateTime.now();
  }

  toJSON() {
    return {
      "id": id,
      "tempsDeParole": tempsDeParole,
      "reunion": reunion.toJSON(),
      "participant": participant.toJSON(),
      "arrivee": arrivee.toIso8601String(),
      "debutParole": debutParole.toIso8601String(),
      "finParole": finParole.toIso8601String(),
      "veutParlerDate": veutParlerDate.toIso8601String(),
      "parle": parle,
      "veutParler": veutParler,
    };
  }
}
