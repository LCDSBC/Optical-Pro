import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../models/patient_model.dart';
import '../../domain/entities/patient.dart';
import '../../domain/repositories/patient_repository.dart';

class FirebasePatientRepository implements PatientRepository {
  const FirebasePatientRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection(AppConstants.firestorePatientsCollection);

  @override
  Future<void> savePatient(Patient patient) {
    return _collection
        .doc(patient.id)
        .set(PatientModel.fromEntity(patient).toMap());
  }

  @override
  Stream<List<Patient>> watchPatients() {
    return _collection
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(PatientModel.fromFirestore)
              .where((patient) => patient.name.trim().isNotEmpty)
              .toList(growable: false),
        );
  }
}
