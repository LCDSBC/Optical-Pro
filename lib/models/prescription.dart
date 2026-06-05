class Prescription {
  const Prescription({
    required this.sphere,
    required this.cylinder,
    required this.axis,
  });

  final double sphere;
  final double cylinder;
  final int axis;

  Prescription copyWith({double? sphere, double? cylinder, int? axis}) {
    return Prescription(
      sphere: sphere ?? this.sphere,
      cylinder: cylinder ?? this.cylinder,
      axis: axis ?? this.axis,
    );
  }
}
