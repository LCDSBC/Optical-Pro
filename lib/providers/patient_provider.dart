import 'package:flutter/foundation.dart';

import '../models/patient.dart';
import '../services/patient_repository.dart';

class PatientProvider extends ChangeNotifier {
  PatientProvider({required this.repository});

  final PatientRepository repository;

  bool _isLoading = false;
  String? _errorMessage;
  List<Patient> _patients = <Patient>[];

  bool get isLoading => _isLoading;
  bool get usesFirebase => repository.usesFirebase;
  String? get errorMessage => _errorMessage;
  List<Patient> get patients => List.unmodifiable(_patients);

  Future<void> loadPatients() async {
    _setLoading(true);
    try {
      _patients = await repository.fetchPatients();
      _errorMessage = null;
    } on Object catch (error) {
      _errorMessage = 'Nao foi possivel carregar pacientes: $error';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> savePatient(Patient patient) async {
    _setLoading(true);
    try {
      await repository.savePatient(patient);
      _patients = await repository.fetchPatients();
      _errorMessage = null;
    } on Object catch (error) {
      _errorMessage = 'Nao foi possivel salvar paciente: $error';
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
