import 'package:totalUnit/feature/domain/enums/numeral_unit.dart';

extension NumeralUnitExtension on NumeralUnit{
  String get label{
    switch(this){
      case NumeralUnit.decimal:
        return "Decimal (Base 10)";
      case NumeralUnit.binary:
        return "Binary (Base 2)";
      case NumeralUnit.octal:
        return "Octal (Base 8)";
      case NumeralUnit.hex:
        return "Hexadecimal (Base 16)";
    }
  }
}