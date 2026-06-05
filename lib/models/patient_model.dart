import 'package:cloud_firestore/cloud_firestore.dart';

import '../modules/patients/domain/entities/patient.dart';

class PatientModel extends Patient {
  const PatientModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
    super.document,
    super.phone,
    super.clinicalNotes,
  });

  factory PatientModel.fromEntity(Patient patient) {
    return PatientModel(
      id: patient.id,
      name: patient.name,
      document: patient.document,
      phone: patient.phone,
      clinicalNotes: patient.clinicalNotes,
      createdAt: patient.createdAt,
      updatedAt: patient.updatedAt,
    );
  }

  factory PatientModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data() ?? <String, dynamic>{};
    return PatientModel(
      id: snapshot.id,
      name: data['name'] as String? ?? '',
      document: data['document'] as String?,
      phone: data['phone'] as String?,
      clinicalNotes: data['clinicalNotes'] as String?,
      createdAt: _readDateTime(data['createdAt']),
      updatedAt: _readDateTime(data['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'document': document,
      'phone': phone,
      'clinicalNotes': clinicalNotes,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  static DateTime _readDateTime(Object? value) {
    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    return DateTime.now();
  }
}
