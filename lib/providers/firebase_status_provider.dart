import 'package:flutter/foundation.dart';

import '../core/firebase/firebase_bootstrap.dart';

class FirebaseStatusProvider extends ChangeNotifier {
  FirebaseStatusProvider(this._status);

  FirebaseBootstrapResult _status;

  FirebaseBootstrapResult get status => _status;
  bool get isInitialized => _status.isInitialized;
  String? get projectId => _status.projectId;

  void update(FirebaseBootstrapResult status) {
    _status = status;
    notifyListeners();
  }
}
