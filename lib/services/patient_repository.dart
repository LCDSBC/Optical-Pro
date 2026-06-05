import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/patient.dart';
import 'firebase_bootstrap_service.dart';

class PatientRepository {
  PatientRepository({required FirebaseStatus firebaseStatus})
    : _firestore = firebaseStatus.isOnline ? FirebaseFirestore.instance : null;

  PatientRepository.memory() : _firestore = null;

  final FirebaseFirestore? _firestore;
  final List<Patient> _memoryPatients = <Patient>[];

  bool get usesFirebase => _firestore != null;

  CollectionReference<Map<String, dynamic>>? get _collection =>
      _firestore?.collection('patients');

  Future<List<Patient>> fetchPatients() async {
    final collection = _collection;
    if (collection == null) {
      return List<Patient>.unmodifiable(_sorted(_memoryPatients));
    }

    final snapshot = await collection
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => Patient.fromMap({...doc.data(), 'id': doc.id}))
        .toList(growable: false);
  }

  Future<Patient> savePatient(Patient patient) async {
    final collection = _collection;
    final id = patient.id.isEmpty
        ? DateTime.now().microsecondsSinceEpoch.toString()
        : patient.id;
    final savedPatient = patient.copyWith(id: id);

    if (collection == null) {
      final index = _memoryPatients.indexWhere((item) => item.id == id);
      if (index >= 0) {
        _memoryPatients[index] = savedPatient;
      } else {
        _memoryPatients.add(savedPatient);
      }
      return savedPatient;
    }

    await collection.doc(id).set(savedPatient.toMap());
    return savedPatient;
  }

  List<Patient> _sorted(List<Patient> patients) {
    return [...patients]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
}
