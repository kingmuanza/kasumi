import 'package:kasumi/models/utilisateur.model.dart';

class Participant {
  Utilisateur utilisateur = Utilisateur.create("Aucun utilisateur");
  String role = "Participant";
  int tempsDeParole = 0;

  Participant();

  Participant.fromJSON(Map<String, dynamic> json) {
    print("Reunion.fromJSON");
    role = json["role"];
    tempsDeParole = json["tempsDeParole"];
    utilisateur = json["utilisateur"] != null ? Utilisateur.fromJSON(json["utilisateur"]) : Utilisateur.create("Aucun utilisateur");
  }

  toJSON() {
    return {
      "role": role,
      "tempsDeParole": tempsDeParole,
      "utilisateur": utilisateur.toJSON(),
    };
  }
}
