import 'package:totalUnit/feature/domain/enums/torque_unit.dart';

extension TorqueUnitExtension on TorqueUnit{
  String get label{
    switch(this){
      case TorqueUnit.nm_torque:
        return "Newton Meter (N·m)";
      case TorqueUnit.knm:
        return "Kilonewton Meter (kN·m)";
      case TorqueUnit.nm_cm:
        return "Newton Centimeter (N·cm)";
      case TorqueUnit.ftlb_torque:
        return "Foot Pound (ft·lb)";
      case TorqueUnit.inlb_torque:
        return "Inch Pound (in·lb)";
      case TorqueUnit.inoz_torque:
        return "Inch Ounce (in·oz)";
      case TorqueUnit.kgm:
        return "Kilogram Meter (kgf·m)";
      case TorqueUnit.kgcm:
        return "Kilogram Centimeter (kgf·cm)";
    }
  }
}