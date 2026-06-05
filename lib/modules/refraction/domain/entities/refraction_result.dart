import 'eye_prescription.dart';

class EyeRefractionResult {
  const EyeRefractionResult({
    required this.original,
    required this.transposed,
    required this.sphericalEquivalent,
  });

  final EyePrescription original;
  final EyePrescription transposed;
  final double sphericalEquivalent;
}

class RefractionResult {
  const RefractionResult({
    required this.rightEye,
    required this.leftEye,
    required this.clinicalInterpretation,
  });

  final EyeRefractionResult rightEye;
  final EyeRefractionResult leftEye;
  final List<String> clinicalInterpretation;
}
