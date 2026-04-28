import 'package:convertify/feature/domain/enums/force_unit.dart';

extension  ForceUnitExtension on ForceUnit{
  String get label{
    switch(this){
    case ForceUnit.newton:
       return "Newton (N)";
     case ForceUnit.kilonewton:
       return "Kilonewton(kN)";
    case ForceUnit.meganewton:
      return "Meganewton (MN)";
    case ForceUnit.dyne:
      return "Dyne (dyn)";
      case ForceUnit.lbf:
        return "Pound-force (lbf)";
    case ForceUnit.kgf:
      return "Kilogram-force (kgf)";
    case ForceUnit.tf:
      return "Tonne-force(tf)";
      case ForceUnit.ozf:
        return "Ounce-force (ozf)";
    }
  }
}