import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/patient.dart';

abstract class PatientRepository {
  Future<List<Patient>> fetchPatients();

  Future<void> savePatient(Patient patient);
}

class MemoryPatientRepository implements PatientRepository {
  MemoryPatientRepository()
    : _patients = [
        Patient(
          id: 'demo-1',
          name: 'Marina Costa',
          birthDate: DateTime(1982, 7, 12),
          lastVisit: DateTime.now().subtract(const Duration(days: 14)),
          notes: 'Presbiopia inicial, adaptação multifocal em andamento.',
        ),
        Patient(
          id: 'demo-2',
          name: 'Rafael Lima',
          birthDate: DateTime(1996, 3, 3),
          lastVisit: DateTime.now().subtract(const Duration(days: 45)),
          notes: 'Controle de LC tórica e revisão de eixo.',
        ),
      ];

  final List<Patient> _patients;

  @override
  Future<List<Patient>> fetchPatients() async {
    return List.unmodifiable(_patients);
  }

  @override
  Future<void> savePatient(Patient patient) async {
    final index = _patients.indexWhere((item) => item.id == patient.id);
    if (index == -1) {
      _patients.add(patient);
    } else {
      _patients[index] = patient;
    }
  }
}

class FirestorePatientRepository implements PatientRepository {
  FirestorePatientRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<List<Patient>> fetchPatients() async {
    final snapshot = await _firestore.collection('patients').get();
    return snapshot.docs.map((doc) => Patient.fromMap(doc.data())).toList();
  }

  @override
  Future<void> savePatient(Patient patient) {
    return _firestore
        .collection('patients')
        .doc(patient.id)
        .set(patient.toMap());
  }
}
