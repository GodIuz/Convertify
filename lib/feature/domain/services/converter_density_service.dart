import 'package:totalUnit/feature/domain/enums/density_unit.dart';

class ConverterDensityService {
  static const Map <DensityUnit, double> densityTo = {
    DensityUnit.kgm3: 1.0,
    DensityUnit.gcm3: 1000.0,
    DensityUnit.gml: 1000.0,
    DensityUnit.kgl: 1000.0,
    DensityUnit.gl: 1.0,
    DensityUnit.mgml: 1.0,
    DensityUnit.lbft3: 16.01846,
    DensityUnit.lbin3: 27679.9,
    DensityUnit.lbgalus: 119.8264,
    DensityUnit.ozin3: 1729.99,
  };

  double convert(double value, DensityUnit from, DensityUnit to) {
    if (from == to) return value;
    final double valueInBase = value * (densityTo[from] ?? 1.0);
    return valueInBase / (densityTo[to] ?? 1.0);
  }

  String formatResult(double value) {
    if (value == 0) return "0";
    if (value.abs() < 0.0001 || value.abs() > 999999) {
      return value.toStringAsExponential(4);
    }
    return double.parse(value.toStringAsFixed(4)).toString();
  }
}