class Patient {
  const Patient({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.document,
    this.phone,
    this.clinicalNotes,
  });

  final String id;
  final String name;
  final String? document;
  final String? phone;
  final String? clinicalNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
}
