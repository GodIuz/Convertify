import 'package:convertify/feature/domain/enums/cooking_unit.dart';

extension CookingUnitExtension on CookingUnit{
  String get label{
    switch(this){
      case CookingUnit.cupUsCook:
        return "Cup (US cup)";
      case CookingUnit.cupMetricCook:
        return "Cup (Metric cup)";
      case CookingUnit.cupImperial:
        return "Cup (Imperial cup)";
      case CookingUnit.tbspUsCook:
        return "Tablespoon (US tbsp)";
      case CookingUnit.tbspAu:
        return "Tablespoon (AU tbsp) ";
      case CookingUnit.tbspUk:
        return "Tablespoon (UK tbsp)";
      case CookingUnit.tspUsCook:
        return "Teaspoon (US tsp)";
      case CookingUnit.tspMetric:
        return "Teaspoon (Metric  tsp)";
      case CookingUnit.flOzUsCook:
        return "Fluid Ounce (US fl oz)";
      case CookingUnit.pintUsCook:
        return "Pint (US pt)";
      case CookingUnit.mlCook:
        return "Milliliter (mL)";
      case CookingUnit.literCook:
        return "Liter (L)";
      case CookingUnit.pinch:
        return "Pinch (pinch)";
      case CookingUnit.dash:
        return "Dash (dash)";
      case CookingUnit.smidgen:
        return "Smidgen (sm)";
    }
  }
}