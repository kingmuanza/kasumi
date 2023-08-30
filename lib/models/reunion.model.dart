class Reunion {
  String id = "";
  String nom = "";
  String code = "";
  bool terminee = false;
  DateTime debut = DateTime.now();

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
  }

  toJSON() {
    return {
      "id": id,
      "code": code,
      "nom": nom,
      "terminee": terminee,
      "debut": debut.toIso8601String(),
    };
  }
}
