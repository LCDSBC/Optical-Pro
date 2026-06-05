import 'package:flutter/material.dart';

import 'app.dart';
import 'services/firebase_bootstrap_service.dart';
import 'services/patient_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final firebaseBootstrap = FirebaseBootstrapService();
  final firebaseStatus = await firebaseBootstrap.initialize();

  runApp(
    OptiCalcProApp(
      firebaseStatus: firebaseStatus,
      patientRepository: PatientRepository(firebaseStatus: firebaseStatus),
    ),
  );
}
