import 'package:cloud_functions/cloud_functions.dart';

class FirebaseFunctionsService {
  const FirebaseFunctionsService(this.functions);

  final FirebaseFunctions functions;

  HttpsCallable callable(String name) => functions.httpsCallable(name);
}
