import 'package:totalUnit/feature/domain/enums/energy_unit.dart';

extension EnergyUnitExtension on EnergyUnit{
  String get label {
    switch(this){
      case EnergyUnit.joule:
        return "Joule (J)";
      case EnergyUnit.kilojoule:
        return "Kilojoule (kJ)";
      case EnergyUnit.megajoule:
        return "Megajoule (MJ)";
      case EnergyUnit.gigajoule:
        return "Gigajoule (GJ)";
      case EnergyUnit.calorie:
        return "Calorie (small) (cal)";
      case EnergyUnit.kilocalorie:
        return "Kilocalorie (food) (kcal)";
      case EnergyUnit.wh:
        return "Watt-hour (Wh)";
      case EnergyUnit.kwh:
        return "Kilowatt-hour (kWh)";
      case EnergyUnit.mwh:
        return "Megawatt-hour (MWh)";
      case EnergyUnit.btu:
        return "BTU (btu)";
      case EnergyUnit.therm:
        return "Therm (thm)";
      case EnergyUnit.electronvolt:
        return "Electronvolt (eV)";
      case EnergyUnit.erg:
        return "Erg (erg)";
      case EnergyUnit.ftlb:
        return "Foot-pound (ft·lb)";
      case EnergyUnit.inlb:
        return "Inch-pound (in·lb)";
      case EnergyUnit.nm:
        return "Newton-meter (N·m)";
    }
  }
}