import 'package:intl/intl.dart';

abstract final class DiopterFormatter {
  static final NumberFormat _plain = NumberFormat('0.00');

  static String signed(double value) {
    final prefix = value > 0 ? '+' : '';
    return '$prefix${_plain.format(value)} D';
  }

  static String plain(double value) => '${_plain.format(value)} D';

  static String prism(double value) => '${_plain.format(value)} prismas';
}
