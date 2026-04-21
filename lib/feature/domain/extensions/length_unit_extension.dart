import '../enums/length_unit.dart';

extension LengthUnitExtension on LengthUnit {

  String get label {
    switch (this) {
      case LengthUnit.meter:
        return "Meter (m)";
      case LengthUnit.kilometer:
        return "Kilometer (km)";
      case LengthUnit.centimeter:
        return "Centimeter (cm)";
      case LengthUnit.millimeter:
        return "Millimeter (mm)";
      case LengthUnit.decimeter:
        return "Decimeter (dm)";
      case LengthUnit.inch:
        return "Inch (in)";
      case LengthUnit.foot:
        return "Foot (ft)";
      case LengthUnit.yard:
        return "Yard (yd)";
      case LengthUnit.mile:
        return "Mile (mi)";
      case LengthUnit.nauticalMile:
        return "Nautical Mile (nmi)";
      case LengthUnit.micrometer:
        return "Micrometer (µm)";
      case LengthUnit.nanometer:
        return "Nanometer (nm)";
      case LengthUnit.astronomicalUnit:
        return "Astronomical Unit (AU)";
      case LengthUnit.lightYear:
        return "Light Year (ly)";
    }
  }
}