import 'package:convertify/feature/domain/enums/radiation_unit.dart';

extension RadiationUnitExtension on RadiationUnit{
  String get label{
    switch(this){
      case RadiationUnit.gray:
        return "Gray (Gy)";
      case RadiationUnit.sievert:
        return "Sievert (Sv)";
      case RadiationUnit.millisievert:
        return "Millisievert (mSv)";
      case RadiationUnit.microsievert:
        return "Microsievert (µSv)";
      case RadiationUnit.radDose:
        return "Rad (rad)";
      case RadiationUnit.rem:
        return "Rem (rem)";
      case RadiationUnit.millirem:
        return "Millirem (mrem)";
      case RadiationUnit.becquerel:
        return "Becquerel (Bq)";
      case RadiationUnit.curie:
        return "Curie (Ci)";
    }
  }
}