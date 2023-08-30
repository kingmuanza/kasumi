import 'package:kasumi/models/utilisateur.model.dart';

class Reunion {
  String id = "";
  String nom = "";
  String code = "";
  bool terminee = false;
  DateTime debut = DateTime.now();
  Utilisateur utilisateur = Utilisateur.create("Aucun utilisateur");

  Reunion();

  Reunion.create(String leNom) {
    nom = leNom;
    debut = DateTime.now();
  }

  Reunion.fromJSON(Map<String, dynamic> json) {
    print("Reunion.fromJSON");
    id = json["id"];
    print("id :" + id);
    code = json["code"];
    nom = json["nom"];
    terminee = json["terminee"] ?? false;
    print("nom :" + nom);
    debut = json["debut"] != null ? DateTime.parse(json["debut"]) : DateTime.now();
    utilisateur = json["utilisateur"] != null ? Utilisateur.fromJSON(json["utilisateur"]) : Utilisateur.create("Aucun utilisateur");
  }

  toJSON() {
    return {
      "id": id,
      "code": code,
      "nom": nom,
      "terminee": terminee,
      "debut": debut.toIso8601String(),
      "utilisateur": utilisateur.toJSON(),
    };
  }
}
