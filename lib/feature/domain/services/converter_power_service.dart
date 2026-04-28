import 'dart:math';

import 'package:convertify/feature/domain/enums/power_unit.dart';

class ConverterPowerService {
  static const Map<PowerUnit,double> powerTo={
   PowerUnit.watt: 1.0,
   PowerUnit.milliwatt: 0.001,
   PowerUnit.kilowatt: 1000.0,
   PowerUnit.megawatt: 1000000.0,
   PowerUnit.gigawatt: 1000000000.0,
   PowerUnit.horsepower: 745.699872,
   PowerUnit.hp_metric: 735.49875,
   PowerUnit.btu_h: 0.293071,
   PowerUnit.calorie_s: 4.184,
   PowerUnit.ton_refrig: 3516.85,
   PowerUnit.dbm: 0.0,
};

  double convertPower({required double value, required PowerUnit from, required PowerUnit to}) {
    if (from == to) return value;

    double watts;
    if (from == PowerUnit.dbm) {
      watts = pow(10, value / 10) / 1000;
    } else {
      watts = value * powerTo[from]!;
    }

    if (to == PowerUnit.dbm) {
      if (watts <= 0) return -999.0;
      return 10 * (log(watts * 1000) / ln10);
    } else {
      return watts / powerTo[to]!;
    }
  }
}