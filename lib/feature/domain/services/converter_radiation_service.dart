import 'package:totalUnit/feature/domain/enums/radiation_unit.dart';

class ConverterRadiationService {
  static Map<RadiationUnit,double> radiationTo = {
   RadiationUnit.gray: 1.0,
   RadiationUnit.sievert: 1.0,
   RadiationUnit.millisievert: 0.001,
   RadiationUnit.microsievert: 0.000001,
   RadiationUnit.radDose: 0.01,
   RadiationUnit.rem: 0.01,
   RadiationUnit.millirem: 0.00001,
   RadiationUnit.becquerel: 1.0,
   RadiationUnit.curie: 37000000000.0
  };

  Map<RadiationUnit, String> convert(double value, RadiationUnit fromUnit) {
    Map<RadiationUnit, String> results = {};
    double factorFrom = radiationTo[fromUnit] ?? 1.0;
    double baseValue = value * factorFrom;

    for (var unit in RadiationUnit.values) {
      if (_getCategory(unit) == _getCategory(fromUnit)) {
        double factorTo = radiationTo[unit] ?? 1.0;
        double converted = baseValue / factorTo;
        results[unit] = _format(converted);
      } else {
        results[unit] = "N/A";
      }
    }
    return results;
  }

  String _getCategory(RadiationUnit unit) {
    if (unit == RadiationUnit.becquerel || unit == RadiationUnit.curie) {
      return "activity";
    }
    return "dose";
  }

  String _format(double val) {
    if (val == 0) {
      return "0";
    }

    if (val.abs() < 0.00001 || val.abs() > 1000000) {
      return val.toStringAsExponential(4);
    }
    return double.parse(val.toStringAsFixed(8)).toString();
  }
}