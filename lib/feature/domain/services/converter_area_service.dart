import 'package:totalUnit/feature/domain/enums/area_unit.dart';

class ConverterAreaService {
  static const Map<AreaUnit, double> toBaseValue ={
   AreaUnit.sq_mm: 1e-6,
   AreaUnit.sq_cm: 1e-4,
   AreaUnit.sq_meter: 1.0,
   AreaUnit.sq_km: 1e6,
   AreaUnit.sq_inch: 0.00064516,
   AreaUnit.sq_foot: 0.09290304,
   AreaUnit.sq_yard: 0.83612736,
   AreaUnit.sq_mile: 2589988.1103,
   AreaUnit.acre:  4046.8564,
   AreaUnit.hectare: 10000.0,
   AreaUnit.sq_furlong: 40468.5642,
   AreaUnit.township: 93239571.97,
   AreaUnit.sq_light_sec: 8.987551787368e+16
  };

  double convertArea({
    required double value,
    required AreaUnit from,
    required AreaUnit to,
  }) {
    return (value * toBaseValue[from]!) / toBaseValue[to]!;
  }
}