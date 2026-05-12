import 'package:totalUnit/feature/domain/enums/power_unit.dart';

extension PowerUnitExtension on PowerUnit{
  String get label{
    switch(this){
      case PowerUnit.watt: return "Watts (W)";
      case PowerUnit.milliwatt: return "Milliwatts (mW)";
      case PowerUnit.kilowatt: return "Kilowatts (kW)";
      case PowerUnit.megawatt: return "Megawatts (MW)";
      case PowerUnit.gigawatt: return "Gigawatts (GW)";
      case PowerUnit.horsepower: return "Horsepower (hp)";
      case PowerUnit.hp_metric: return "Horsepower (Metric - PS)";
      case PowerUnit.btu_h: return "BTU per hour (BTU/h)";
      case PowerUnit.calorie_s: return "Calories per second";
      case PowerUnit.ton_refrig: return "Tons of Refrigeration";
      case PowerUnit.dbm: return "Decibel-milliwatts (dBm)";
    }
  }
}