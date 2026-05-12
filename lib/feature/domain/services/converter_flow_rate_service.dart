import 'package:totalUnit/feature/domain/enums/flow_rate_unit.dart';

class ConverterFlowRateService {
  static const Map<FlowRateUnit,double> flowTo ={
    FlowRateUnit.ls: 1.0,
    FlowRateUnit.lmin: 1.0 / 60.0,
    FlowRateUnit.lh: 1.0 / 3600.0,
    FlowRateUnit.m3s: 1000.0,
    FlowRateUnit.m3h: 1000.0 / 3600.0,
    FlowRateUnit.mls: 0.001,
    FlowRateUnit.galusmin: 0.0630902,
    FlowRateUnit.galush: 0.0010515,
    FlowRateUnit.ft3s: 28.3168,
    FlowRateUnit.ft3min: 0.471947,
  };

  double convert(double value, FlowRateUnit from, FlowRateUnit to) {
    if (from == to) return value;
    return (value * flowTo[from]!) / flowTo[to]!;
  }

  String formatResult(double value) {
    if (value == 0) return "0";
    if (value.abs() < 0.001 || value.abs() > 999999) {
      return value.toStringAsExponential(4);
    }
    return double.parse(value.toStringAsFixed(4)).toString();
  }
}