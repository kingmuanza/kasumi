import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kasumi/models/reunion.model.dart';

class ReunionService {
  Future<List<Reunion>> getAll() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final querySnapshot = await db.collection("reunions").get();

    List<Reunion> reunions = [];
    // List<dynamic> reunionsMap = await parseJsonFromAssets('assets/json/reunions.json');
    List<dynamic> reunionsMap = [];

    for (var docSnapshot in querySnapshot.docs) {
      print('${docSnapshot.id} => ${docSnapshot.data()}');
      reunionsMap.add(docSnapshot.data());
    }

    print("reunionsMap");
    print(reunionsMap);
    reunionsMap.forEach((reunionMap) {
      print(reunionMap);
      reunions.add(Reunion.fromJSON(reunionMap));
      print("reunions.length");
      print(reunions.length);
    });
    return reunions;
  }

  Future<Reunion> save(Reunion reunion) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection("reunions").doc(reunion.code).set(reunion.toJSON());
    return reunion;
  }
}
