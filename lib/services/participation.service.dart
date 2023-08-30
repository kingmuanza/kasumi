import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kasumi/models/reunion.model.dart';

import '../models/participation.model.dart';

class ParticipationService {
  Future<List<Participation>> getAll() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final querySnapshot = await db.collection("participations").get();

    List<Participation> participations = [];
    List<dynamic> participationsMap = [];

    for (var docSnapshot in querySnapshot.docs) {
      print('${docSnapshot.id} => ${docSnapshot.data()}');
      participationsMap.add(docSnapshot.data());
    }

    print("participationsMap");
    print(participationsMap);
    participationsMap.forEach((participationMap) {
      print(participationMap);
      participations.add(Participation.fromJSON(participationMap));
      print("participations.length");
      print(participations.length);
    });
    return participations;
  }

  Future<List<Participation>> getAllFromReunion(Reunion reunion) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final querySnapshot = await db.collection("participations").where("reunion.id", isEqualTo: reunion.id).get();

    List<Participation> participations = [];
    List<dynamic> participationsMap = [];

    for (var docSnapshot in querySnapshot.docs) {
      print('${docSnapshot.id} => ${docSnapshot.data()}');
      participationsMap.add(docSnapshot.data());
    }

    print("participationsMap");
    print(participationsMap);
    participationsMap.forEach((participationMap) {
      print(participationMap);
      participations.add(Participation.fromJSON(participationMap));
      print("participations.length");
      print(participations.length);
    });
    return participations;
  }

  Future<Participation?> getOne(String id) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docSnapshot = await db.collection("participations").doc(id).get();

    Map<String, dynamic>? resultat = docSnapshot.data();

    if (resultat != null) {
      return Participation.fromJSON(resultat);
    }
    return null;
  }

  Future<Participation> save(Participation participation) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection("participations").doc(participation.id).set(participation.toJSON());
    return participation;
  }
}
