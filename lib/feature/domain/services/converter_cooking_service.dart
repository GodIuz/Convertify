import 'package:totalUnit/feature/domain/enums/cooking_unit.dart';

class ConverterCookingService {
  static Map<CookingUnit, double> cookingTo = {
    CookingUnit.cupUsCook: 236.588,
    CookingUnit.cupMetricCook: 250.0,
    CookingUnit.cupImperial: 284.131,
    CookingUnit.tbspUsCook: 14.787,
    CookingUnit.tbspAu: 20.0,
    CookingUnit.tbspUk: 15.0,
    CookingUnit.tspUsCook: 4.929,
    CookingUnit.tspMetric: 5.0,
    CookingUnit.flOzUsCook: 29.574,
    CookingUnit.pintUsCook: 473.176,
    CookingUnit.mlCook: 1.0,
    CookingUnit.literCook: 1000.0,
    CookingUnit.pinch: 0.308,
    CookingUnit.dash: 0.616,
    CookingUnit.smidgen: 0.154,
  };

  Map<CookingUnit, String> convert(double value, CookingUnit fromUnit) {
    Map<CookingUnit, String> results = {};

    double factorFrom = cookingTo[fromUnit] ?? 1.0;
    double baseValue = value * factorFrom;

    for (var unit in CookingUnit.values) {
      double factorTo = cookingTo[unit] ?? 1.0;
      double converted = baseValue / factorTo;
      results[unit] = _format(converted);
    }
    return results;
  }

  String _format(double val) {
    if (val == 0) return "0";
    if (val.abs() < 0.01) return val.toStringAsFixed(4);
    return double.parse(val.toStringAsFixed(3)).toString();
  }
}