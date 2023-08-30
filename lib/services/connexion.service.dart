import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kasumi/models/utilisateur.model.dart';

class ConnexionService {
  static Utilisateur? utilisateur;
  Future<Utilisateur> connexion(String login, String passe) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final querySnapshot = await db.collection("utilisateurs").where("login", isEqualTo: login).get();
    if (querySnapshot.docs.length > 0) {
      for (var docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> uJSON = docSnapshot.data();
        if (uJSON["passe"] == passe) {
          utilisateur = Utilisateur.fromJSON(uJSON);
          return Utilisateur.fromJSON(uJSON);
        } else {
          throw Exception("Mot de passe incorrect");
        }
      }
    } else {
      throw Exception("Aucun utilisateur trouvé");
    }

    return Utilisateur.create("Muanza Kangudie");
  }
}
