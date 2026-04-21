import '../enums/speed_unit.dart';

class ConverterSpeedService {
  static const Map<SpeedUnit, double> speedToMs = {
    SpeedUnit.ms: 1,
    SpeedUnit.kmh: 1 / 3.6,
    SpeedUnit.kms: 1000,
    SpeedUnit.mph: 0.44704,
    SpeedUnit.fts: 0.3048,
    SpeedUnit.ins: 0.0254,
    SpeedUnit.knots: 0.514444,
    SpeedUnit.mach: 343,
    SpeedUnit.speedlight: 299792458,
    SpeedUnit.cms: 0.01,
    SpeedUnit.mms: 0.001,
    SpeedUnit.ftm: 0.00508,
  };

  double convertSpeed({
    required double value,
    required SpeedUnit from,
    required SpeedUnit to,
  }) {
    final ms = value * speedToMs[from]!;
    return ms / speedToMs[to]!;
  }
}