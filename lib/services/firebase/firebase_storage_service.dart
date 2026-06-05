import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  const FirebaseStorageService(this.storage);

  final FirebaseStorage storage;

  Reference ref(String path) => storage.ref(path);
}
