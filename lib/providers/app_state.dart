import 'package:flutter/foundation.dart';

import '../services/firebase_service.dart';

class AppState extends ChangeNotifier {
  AppState(this.firebaseStatus);

  final FirebaseStatus firebaseStatus;
  int _selectedModuleIndex = 0;

  int get selectedModuleIndex => _selectedModuleIndex;

  void selectModule(int index) {
    if (index == _selectedModuleIndex) {
      return;
    }

    _selectedModuleIndex = index;
    notifyListeners();
  }
}
