import 'package:totalUnit/feature/domain/enums/digital%20_unit.dart';

extension DigitalUnitExtension on DigitalUnit{
  String get label {
    switch (this) {
      case DigitalUnit.bit: return "Bits (b)";
      case DigitalUnit.byte: return "Bytes (B)";
      case DigitalUnit.kilobyte: return "Kilobytes (KB)";
      case DigitalUnit.megabyte: return "Megabytes (MB)";
      case DigitalUnit.gigabyte: return "Gigabytes (GB)";
      case DigitalUnit.terabyte: return "Terabytes (TB)";
      case DigitalUnit.petabyte: return "Petabytes (PB)";
    }
  }
}