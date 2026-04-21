import '../enums/weight_unit.dart';

class ConverterWeightService {
  static const Map<WeightUnit, double> weightToKilogram = {
    WeightUnit.milligram: 1e-6,
    WeightUnit.gram: 0.001,
    WeightUnit.kilogram: 1,
    WeightUnit.metricTon: 1000,
    WeightUnit.ounce: 0.0283495,
    WeightUnit.pound: 0.453592,
    WeightUnit.stone: 6.35029,
    WeightUnit.tonShort: 907.185,
    WeightUnit.tonLong: 1016.05,
    WeightUnit.troyOunce: 0.0311035,
    WeightUnit.carat: 0.0002,
  };

  double convertWeight({
    required double value,
    required WeightUnit from,
    required WeightUnit to,
  }) {
    final kg = value * weightToKilogram[from]!;
    return kg / weightToKilogram[to]!;
  }
}