import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService {
  const FirebaseFirestoreService(this.firestore);

  final FirebaseFirestore firestore;

  CollectionReference<Map<String, dynamic>> collection(String path) {
    return firestore.collection(path);
  }
}
