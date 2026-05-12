import 'package:totalUnit/feature/domain/enums/area_unit.dart';

extension AreaUnitExtension on AreaUnit{
  String get label {
    switch (this) {
      case AreaUnit.sq_meter:
        return "Square Meter (m²)";
      case AreaUnit.sq_km:
        return "Square Kilometer (km²)";
      case AreaUnit.sq_cm:
        return "Square Centimeter (cm²)";
      case AreaUnit.sq_mm:
        return "Square Millimeter (mm²)";
      case AreaUnit.sq_mile:
        return "Square Mile (mi²)";
      case AreaUnit.sq_yard:
          return "Square Yard (yd²)";
      case AreaUnit.sq_foot:
        return "Square Foot (ft²)";
      case AreaUnit.sq_inch:
        return "Square Inch (in²)";
      case AreaUnit.acre:
        return "Acre (ac)";
      case AreaUnit.hectare:
      return "Hectare (ha)";
      case AreaUnit.sq_furlong:
        return "Square Furlong (fur²)";
      case AreaUnit.township:
        return "Township (twp";
      case AreaUnit.sq_light_sec:
         return "Square Light Second (ls²)";
    }
  }
}