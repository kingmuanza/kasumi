class Utilisateur {
  String id = "";
  String nom = "";
  String login = "";
  String passe = "";
  String photo = "";
  String role = "";

  Utilisateur.create(String leNom) {
    nom = leNom;
  }

  Utilisateur.fromJSON(Map<String, dynamic> json) {
    print("Utilisateur.fromJSON");
    id = json["id"];
    print("id :" + id);
    login = json["login"];
    nom = json["nom"];
    passe = json["passe"] ?? "";
    photo = json["photo"] ?? "";
    role = json["role"] ?? "";
    print("nom :" + nom);
  }

  toJSON() {
    return {
      "id": id,
      "login": login,
      "nom": nom,
      "passe": passe,
      "photo": photo,
      "role": role,
    };
  }
}
