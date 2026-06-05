import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../core/firebase/firebase_bootstrap.dart';
import '../modules/patients/data/repositories/firebase_patient_repository.dart';
import '../modules/patients/domain/repositories/patient_repository.dart';
import '../services/firebase/firebase_auth_service.dart';
import '../services/firebase/firebase_firestore_service.dart';
import '../services/firebase/firebase_functions_service.dart';
import '../services/firebase/firebase_storage_service.dart';
import '../services/optical_formula_service.dart';

/// Dependencies assembled once during application startup.
class AppDependencies {
  const AppDependencies({
    required this.firebaseStatus,
    required this.opticalFormulaService,
    this.authService,
    this.firestoreService,
    this.functionsService,
    this.storageService,
    this.patientRepository,
  });

  final FirebaseBootstrapResult firebaseStatus;
  final OpticalFormulaService opticalFormulaService;
  final FirebaseAuthService? authService;
  final FirebaseFirestoreService? firestoreService;
  final FirebaseFunctionsService? functionsService;
  final FirebaseStorageService? storageService;
  final PatientRepository? patientRepository;
}

Future<AppDependencies> bootstrap() async {
  final firebaseStatus = await FirebaseBootstrap.initialize();
  final firestore = firebaseStatus.isInitialized ? FirebaseFirestore.instance : null;

  return AppDependencies(
    firebaseStatus: firebaseStatus,
    opticalFormulaService: const OpticalFormulaService(),
    authService: firebaseStatus.isInitialized
        ? FirebaseAuthService(FirebaseAuth.instance)
        : null,
    firestoreService:
        firestore == null ? null : FirebaseFirestoreService(firestore),
    functionsService: firebaseStatus.isInitialized
        ? FirebaseFunctionsService(FirebaseFunctions.instance)
        : null,
    storageService: firebaseStatus.isInitialized
        ? FirebaseStorageService(FirebaseStorage.instance)
        : null,
    patientRepository:
        firestore == null ? null : FirebasePatientRepository(firestore),
  );
}
