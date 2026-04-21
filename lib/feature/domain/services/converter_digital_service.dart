import '../enums/digital _unit.dart';

class ConverterDigitalService {
  static const Map<DigitalUnit, double> digitalToByte = {
    DigitalUnit.bit: 0.125,
    DigitalUnit.byte: 1.0,
    DigitalUnit.kilobyte: 1024.0,
    DigitalUnit.megabyte: 1024.0 * 1024.0,
    DigitalUnit.gigabyte: 1024.0 * 1024.0 * 1024.0,
    DigitalUnit.terabyte: 1024.0 * 1024.0 * 1024.0 * 1024.0,
    DigitalUnit.petabyte: 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0,
  };

  double convertDigital({
    required double value,
    required DigitalUnit from,
    required DigitalUnit to,
  }) {
    final bytes = value * digitalToByte[from]!;
    return bytes / digitalToByte[to]!;
  }
}