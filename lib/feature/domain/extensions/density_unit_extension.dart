import 'package:convertify/feature/domain/enums/density_unit.dart';

extension DesnsityUnitExtension on DensityUnit{
  String get label{
    switch(this){
      case DensityUnit.kgm3:
        return "Kilogram/m³ (kg/m³) ";
      case DensityUnit.gcm3:
        return "Gram/cm³ (g/cm³)";
      case DensityUnit.gml:
        return "Gram/mL (g/mL)";
      case DensityUnit.kgl:
        return "Kilogram/liter (kg/L)";
      case DensityUnit.gl:
        return "Gram/liter (g/L)";
      case DensityUnit.mgml:
        return "Milligram/mL (mg/mL)";
      case DensityUnit.lbft3:
        return "Pound/ft³ (lb/ft³)";
      case DensityUnit.lbin3:
        return "Pound/in³ (lb/in³)";
      case DensityUnit.lbgalus:
        return "Pound/gallon (US lb/gal) ";
      case DensityUnit.ozin3:
        return "Ounce/in³ (oz/in³)";
    }
  }
}