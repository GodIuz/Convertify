import 'package:intl/intl.dart';

class NumberFormatter {
  static String format(double value) {
    if (value == 0) return "0";

    if (value.abs() < 0.001 && value.abs() > 0) {
      return value.toStringAsExponential(4);
    }

    final formatter = NumberFormat.decimalPattern('en_US')..maximumFractionDigits = 6;
    return formatter.format(value);
  }
}