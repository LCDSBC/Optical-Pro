class Patient {
  const Patient({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.notes,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String phone;
  final String email;
  final String notes;
  final DateTime createdAt;

  Patient copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? notes,
    DateTime? createdAt,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Patient.fromMap(Map<String, Object?> map) {
    return Patient(
      id: (map['id'] as String?) ?? '',
      name: (map['name'] as String?) ?? '',
      phone: (map['phone'] as String?) ?? '',
      email: (map['email'] as String?) ?? '',
      notes: (map['notes'] as String?) ?? '',
      createdAt:
          DateTime.tryParse((map['createdAt'] as String?) ?? '') ??
          DateTime.now(),
    );
  }
}
