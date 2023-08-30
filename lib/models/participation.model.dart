import 'package:kasumi/models/participant.model.dart';
import 'package:kasumi/models/reunion.model.dart';

class Participation {
  Participant participant = Participant();
  Reunion reunion = Reunion();
  DateTime arrivee = DateTime.now();

  Participation();

  Participation.fromJSON(Map<String, dynamic> json) {
    print("Reunion.fromJSON");
    participant = json["participant"] != null ? Participant.fromJSON(json["participant"]) : Participant();
    reunion = json["reunion"] != null ? Reunion.fromJSON(json["reunion"]) : Reunion();

    arrivee = json["arrivee"] != null ? DateTime.parse(json["arrivee"]) : DateTime.now();
  }

  toJSON() {
    return {
      "reunion": reunion.toJSON(),
      "participant": participant.toJSON(),
      "arrivee": arrivee.toIso8601String(),
    };
  }
}
