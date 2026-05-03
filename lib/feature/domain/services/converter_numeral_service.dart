import '../enums/numeral_unit.dart';

class ConverterNumeralService {
  String convertNumeral({
    required String value,
    required NumeralUnit from,
    required NumeralUnit to,
  }) {
    if (value.isEmpty) return "0";

    try {
      final int decimalValue = int.parse(value, radix: _getRadix(from));
      return decimalValue.toRadixString(_getRadix(to)).toUpperCase();
    } catch (e) {
      return "Invalid Input";
    }
  }

  int _getRadix(NumeralUnit unit) {
    switch (unit) {
      case NumeralUnit.binary: return 2;
      case NumeralUnit.octal: return 8;
      case NumeralUnit.decimal: return 10;
      case NumeralUnit.hex: return 16;
    }
  }
}