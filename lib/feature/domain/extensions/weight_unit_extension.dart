import 'package:totalUnit/feature/domain/enums/weight_unit.dart';

extension WeightUnitExtensions on WeightUnit{
  String get label{
      switch(this){
        case WeightUnit.milligram: return "Milligram (mg)";
        case WeightUnit.gram: return "Gram (g)";
        case WeightUnit.kilogram: return "Kilogram (kg)";
        case WeightUnit.metricTon: return "Metric Ton (t)";
        case WeightUnit.ounce: return "Ounce (oz)";
        case WeightUnit.pound: return "Pound (lb)";
        case WeightUnit.stone: return "Stone (st)";
        case WeightUnit.tonShort: return "American Ton";
        case WeightUnit.tonLong: return "English Ton";
        case WeightUnit.troyOunce: return "Troy Ounce";
        case WeightUnit.carat: return "Carat (ct)";
      }
  }
}