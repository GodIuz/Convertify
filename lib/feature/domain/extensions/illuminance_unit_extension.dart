import 'package:convertify/feature/domain/enums/illuminance_unit.dart';

extension IlluminanceUnitExtension on IlluminanceUnit{
  String get label{
    switch(this){
      case IlluminanceUnit.lux:
        return "Lux (lx)";
      case IlluminanceUnit.footcandle:
        return "Foot-candle (fc)";
      case IlluminanceUnit.phot:
        return "Phot (ph)";
      case IlluminanceUnit.nit:
        return "Nit (nt)";
      case IlluminanceUnit.lumen:
        return "Lumen/m² (lm/m²)";
    }
  }
}