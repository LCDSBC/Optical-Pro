import '../entities/patient.dart';

abstract interface class PatientRepository {
  Stream<List<Patient>> watchPatients();

  Future<void> savePatient(Patient patient);
}
