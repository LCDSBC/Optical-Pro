double parseDecimal(String value) {
  return double.parse(value.replaceAll(',', '.').trim());
}

int parseInteger(String value) {
  return int.parse(value.trim());
}

String formatDiopter(Object? value) {
  if (value is! num) {
    return '--';
  }
  final prefix = value > 0 ? '+' : '';
  return '$prefix${value.toStringAsFixed(2)} D';
}

String formatPlain(Object? value, {String suffix = ''}) {
  if (value is! num) {
    return '--';
  }
  return '${value.toStringAsFixed(2)}$suffix';
}
