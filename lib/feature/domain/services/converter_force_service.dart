import 'package:convertify/feature/domain/enums/force_unit.dart';

class ConverterForceService {
  static const Map<ForceUnit,double> forceTo ={
   ForceUnit.newton: 1.0,
   ForceUnit.kilonewton: 1000.0,
   ForceUnit.meganewton: 1000000.0,
   ForceUnit.dyne: 0.00001,
   ForceUnit.lbf: 4.4482216153,
   ForceUnit.kgf: 9.80665,
   ForceUnit.tf: 9806.65,
   ForceUnit.ozf: 0.27801385
  };

  double convertForce({
    required double value,
    required ForceUnit from,
    required ForceUnit to,
  }) {
    if (from == to) return value;
    return (value * forceTo[from]!) /forceTo[to]!;
  }
}