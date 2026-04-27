import 'package:convertify/feature/domain/enums/area_unit.dart';

extension AreaUnitExtension on AreaUnit{
  String get label {
    switch (this) {
      case AreaUnit.sq_meter:
        return "Square Meter";
      case AreaUnit.sq_km:
        return "Square Kilometer";
      case AreaUnit.sq_cm:
        return "Square Centimeter";
      case AreaUnit.sq_mm:
        return "Square Millimeter";
      case AreaUnit.sq_mile:
        return "Square Mile";
      case AreaUnit.sq_yard:
          return "Square Yard";
      case AreaUnit.sq_foot:
        return "Square Foot";
      case AreaUnit.sq_inch:
        return "Square Inch";
      case AreaUnit.acre:
        return "Acre";
      case AreaUnit.hectare:
      return "Hectare";
      case AreaUnit.sq_furlong:
        return "Square Furlong";
      case AreaUnit.township:
        return "Township";
      case AreaUnit.sq_light_sec:
         return "Square Light Second";
    }
  }
}