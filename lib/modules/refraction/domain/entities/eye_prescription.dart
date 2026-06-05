class EyePrescription {
  const EyePrescription({
    required this.sphere,
    required this.cylinder,
    required this.axis,
    required this.addition,
  });

  final double sphere;
  final double cylinder;
  final int axis;
  final double addition;
}

class RefractionPrescription {
  const RefractionPrescription({required this.rightEye, required this.leftEye});

  final EyePrescription rightEye;
  final EyePrescription leftEye;
}
