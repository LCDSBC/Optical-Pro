import 'package:flutter/material.dart';

import 'app.dart';
import 'services/firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final firebaseStatus = await FirebaseService.initialize();

  runApp(OptiCalcProApp(firebaseStatus: firebaseStatus));
}
