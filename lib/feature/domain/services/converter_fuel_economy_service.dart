import 'package:convertify/feature/domain/enums/fuel_economy_unit.dart';

class ConverterFuelEconomyService {
  static const Map<FuelEconomyUnit,double> efficiency = {
   FuelEconomyUnit.kml: 1.0,
   FuelEconomyUnit.mpg_us: 0.425144,
   FuelEconomyUnit.mpg_uk: 0.354006,
   FuelEconomyUnit.mpl: 1.60934,
   FuelEconomyUnit.km_gallon_us: 0.264172
  };
  double convertFuel({required double value, required FuelEconomyUnit from, required FuelEconomyUnit to}) {
    if (value <= 0) return 0.0;

    double baseKml;
    if (from == FuelEconomyUnit.l100km) {
      baseKml = 100 / value;
    } else if (from == FuelEconomyUnit.l_mile) {
      baseKml = 1.60934 / value;
    } else {
      baseKml = value * efficiency[from]!;
    }

    if (to == FuelEconomyUnit.l100km) {
      return 100 / baseKml;
    } else if (to == FuelEconomyUnit.l_mile) {
      return 1.60934 / baseKml;
    } else {
      return baseKml / efficiency[to]!;
    }
  }
}