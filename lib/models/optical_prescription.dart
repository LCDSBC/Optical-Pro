class OpticalPrescription {
  const OpticalPrescription({
    required this.sphere,
    required this.cylinder,
    required this.axis,
  });

  final double sphere;
  final double cylinder;
  final int axis;

  bool get hasValidAxis => axis >= 0 && axis <= 180;

  OpticalPrescription copyWith({double? sphere, double? cylinder, int? axis}) {
    return OpticalPrescription(
      sphere: sphere ?? this.sphere,
      cylinder: cylinder ?? this.cylinder,
      axis: axis ?? this.axis,
    );
  }
}

class TransposedPrescription {
  const TransposedPrescription({
    required this.sphere,
    required this.cylinder,
    required this.axis,
  });

  final double sphere;
  final double cylinder;
  final int axis;
}
