import 'package:convertify/feature/domain/enums/flow_rate_unit.dart';

extension FlowRateUnitExtension on FlowRateUnit{
  String get label{
    switch(this){
      case FlowRateUnit.ls:
        return "Liter/second (L/s)";
      case FlowRateUnit.lmin:
        return "Liter/minute (L/min)";
      case FlowRateUnit.lh:
        return "Liter/hour (L/h)";
      case FlowRateUnit.m3s:
        return "Cubic meter/second (m³/s)";
      case FlowRateUnit.m3h:
        return "Cubic meter/hour (m³/h)";
      case FlowRateUnit.mls:
        return "Milliliter/second (mL/s)";
      case FlowRateUnit.galusmin:
        return "Gallon/min (US GPM)";
      case FlowRateUnit.galush:
        return "Gallon/hour (US GPH)";
      case FlowRateUnit.ft3s:
        return "Cubic foot/second (ft³/s)";
      case FlowRateUnit.ft3min:
        return "Cubic foot/min (CFM)";
    }
  }
}