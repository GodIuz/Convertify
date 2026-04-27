import 'package:convertify/feature/domain/enums/volume_unit.dart';

extension VolumeUnitExtension on VolumeUnit{
  String get label{
    switch(this){
      case VolumeUnit.liter:
        return "Liter (L)";
      case VolumeUnit.milliliter:
        return "Milliliter (mL)";
      case VolumeUnit.centiliter:
        return "Centiliter (cL)";
      case VolumeUnit.deciliter:
        return "Deciliter (dL)";
      case VolumeUnit.cubic_meter:
        return "Cubic Meter (m³)";
      case VolumeUnit.cubic_cm:
        return "Cubic Centimeter (cm³)";
      case VolumeUnit.cubic_mm:
        return "Cubic Millimeter (mm³)";
      case VolumeUnit.cubic_inch:
        return "Cubic Inch (in³)";
      case VolumeUnit.cubic_foot:
        return "Cubic Foot (ft³)";
      case VolumeUnit.cubic_yard:
        return "Cubic Yard (yd³)";
      case VolumeUnit.gallon_us:
        return "Gallon (US)";
      case VolumeUnit.gallon_uk:
        return "Gallon (UK)";
      case VolumeUnit.quart_us:
        return "Quart (US)";
      case VolumeUnit.pint_us:
        return "Pint (US)";
      case VolumeUnit.pint_uk:
        return "Pint (UK)";
      case VolumeUnit.cup_us:
        return "Cup (US)";
      case VolumeUnit.cup_metric:
        return "Cup (Metric)";
      case VolumeUnit.fluid_oz_us:
        return "Fl. Ounce (US)";
      case VolumeUnit.fluid_oz_uk:
        return "Fl. Ounce (Uk)";
      case VolumeUnit.tablespoon_us:
        return "Tablespoon (US)";
      case VolumeUnit.tablespoon_uk:
        return "Tablespoon (UK)";
      case VolumeUnit.teaspoon_us:
        return "Teaspoon (US)";
      case VolumeUnit.teaspoon_uk:
        return "Teaspoon (UK)";
      case VolumeUnit.barrel_oil:
        return "Barrel (Oil)";
      case VolumeUnit.barrel_us:
        return "Barrel (US Beer)";
      case VolumeUnit.hogshead:
        return "Hogshead";
      case VolumeUnit.drop:
        return "Drop";
    }
  }
}