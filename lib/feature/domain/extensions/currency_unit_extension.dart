import '../enums/currency_unit.dart';

extension CurrencyUnitExtension on CurrencyUnit {
  String get code => name.toUpperCase().replaceAll('_', '');

  String get label {
    return code;
  }
}