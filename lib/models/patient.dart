class Patient {
  const Patient({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.lastVisit,
    required this.notes,
  });

  final String id;
  final String name;
  final DateTime birthDate;
  final DateTime lastVisit;
  final String notes;

  int get age {
    final now = DateTime.now();
    var computedAge = now.year - birthDate.year;
    final birthdayHasPassed =
        now.month > birthDate.month ||
        (now.month == birthDate.month && now.day >= birthDate.day);
    if (!birthdayHasPassed) {
      computedAge--;
    }
    return computedAge;
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'birthDate': birthDate.toIso8601String(),
      'lastVisit': lastVisit.toIso8601String(),
      'notes': notes,
    };
  }

  factory Patient.fromMap(Map<String, Object?> map) {
    return Patient(
      id: map['id'] as String,
      name: map['name'] as String,
      birthDate: DateTime.parse(map['birthDate'] as String),
      lastVisit: DateTime.parse(map['lastVisit'] as String),
      notes: map['notes'] as String? ?? '',
    );
  }
}
