import 'package:kasumi/models/reunion.model.dart';

class ReunionService {
  getAll() {
    return [
      Reunion.create("Ma premiere reunion"),
      Reunion.create("Ma seconde reunion en cours"),
    ];
  }
}
