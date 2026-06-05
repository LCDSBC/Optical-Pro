import 'package:flutter/foundation.dart';

import '../models/patient.dart';
import '../services/patient_repository.dart';

class PatientProvider extends ChangeNotifier {
  PatientProvider(this._repository);

  PatientRepository _repository;
  List<Patient> _patients = const [];
  bool _isLoading = false;
  String? _errorMessage;

  void updateRepository(PatientRepository repository) {
    _repository = repository;
  }

  List<Patient> get patients => List.unmodifiable(_patients);

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> loadPatients() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _patients = await _repository.fetchPatients();
    } catch (error) {
      _errorMessage = 'Não foi possível carregar pacientes.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addQuickPatient(String name, String notes) async {
    if (name.trim().isEmpty) {
      _errorMessage = 'Informe o nome do paciente.';
      notifyListeners();
      return;
    }

    final now = DateTime.now();
    final patient = Patient(
      id: 'patient-${now.microsecondsSinceEpoch}',
      name: name.trim(),
      birthDate: DateTime(now.year - 35, now.month, now.day),
      lastVisit: now,
      notes: notes.trim(),
    );

    await _repository.savePatient(patient);
    await loadPatients();
  }
}
