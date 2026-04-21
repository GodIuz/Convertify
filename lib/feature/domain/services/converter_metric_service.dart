import '../enums/length_unit.dart';

class ConverterMetricService {
  static const Map<LengthUnit, double> lengthToMeter = {
    LengthUnit.meter: 1,
    LengthUnit.kilometer: 1000,
    LengthUnit.decimeter: 0.1,
    LengthUnit.centimeter: 0.01,
    LengthUnit.millimeter: 0.001,
    LengthUnit.micrometer: 1e-6,
    LengthUnit.nanometer: 1e-9,
    LengthUnit.inch: 0.0254,
    LengthUnit.foot: 0.3048,
    LengthUnit.yard: 0.9144,
    LengthUnit.mile: 1609.344,
    LengthUnit.nauticalMile: 1852,
    LengthUnit.astronomicalUnit: 1.496e11,
    LengthUnit.lightYear: 9.461e15,
  };

  double convertLength({
    required double value,
    required LengthUnit from,
    required LengthUnit to,
  }) {
    final meters = value * lengthToMeter[from]!;
    return meters / lengthToMeter[to]!;
  }

}