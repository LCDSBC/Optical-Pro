class AppException implements Exception {
  const AppException(
    this.message, {
    this.code,
    this.details,
  });

  final String message;
  final String? code;
  final Object? details;

  @override
  String toString() {
    final codeLabel = code == null ? '' : '[$code] ';
    return '$codeLabel$message';
  }
}

class FormulaValidationException extends AppException {
  const FormulaValidationException(
    super.message, {
    super.code = 'formula-validation',
    super.details,
  });
}
