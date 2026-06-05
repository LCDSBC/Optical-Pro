import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../domain/entities/patient.dart';
import '../../domain/repositories/patient_repository.dart';

class PatientsProvider extends ChangeNotifier {
  PatientsProvider({required PatientRepository? repository})
      : _repository = repository {
    _subscription = _repository?.watchPatients().listen(
      (patients) {
        _patients = patients;
        _errorMessage = null;
        notifyListeners();
      },
      onError: (Object _) {
        _errorMessage = 'Nao foi possivel carregar pacientes.';
        notifyListeners();
      },
    );
  }

  final PatientRepository? _repository;
  StreamSubscription<List<Patient>>? _subscription;

  List<Patient> _patients = const [];
  String? _errorMessage;

  List<Patient> get patients => _patients;
  String? get errorMessage => _errorMessage;
  bool get isRemoteEnabled => _repository != null;

  Future<void> createPatient({
    required String name,
    String? document,
    String? phone,
    String? clinicalNotes,
  }) async {
    final now = DateTime.now();
    final patient = Patient(
      id: now.microsecondsSinceEpoch.toString(),
      name: name.trim(),
      document: _emptyToNull(document),
      phone: _emptyToNull(phone),
      clinicalNotes: _emptyToNull(clinicalNotes),
      createdAt: now,
      updatedAt: now,
    );

    if (patient.name.isEmpty) {
      _errorMessage = 'Informe o nome do paciente.';
      notifyListeners();
      return;
    }

    if (_repository == null) {
      _patients = [patient, ..._patients];
      _errorMessage = null;
      notifyListeners();
      return;
    }

    try {
      await _repository.savePatient(patient);
      _errorMessage = null;
    } on Object {
      _errorMessage = 'Nao foi possivel salvar o paciente.';
    }

    notifyListeners();
  }

  static String? _emptyToNull(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) {
      return null;
    }

    return normalized;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
