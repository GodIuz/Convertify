import 'package:convertify/feature/domain/enums/fuel_economy_unit.dart';

extension FuelEconomyUnitExtension on  FuelEconomyUnit{
  String get label{
    switch(this){
      case FuelEconomyUnit.kml:
        return "Km per Liter (km/l)";
      case FuelEconomyUnit.l100km:
        return "L per 100 km (L/100km)";
      case FuelEconomyUnit.mpg_us:
        return "MPG (US mpg)";
      case FuelEconomyUnit.mpg_uk:
        return "MPG (UK mpg)";
      case FuelEconomyUnit.mpl:
        return "Miles per Liter (mi/L)";
      case FuelEconomyUnit.km_gallon_us:
        return "Km per Gallon (US km/gal)";
      case FuelEconomyUnit.l_mile:
        return "Litter per Mile (L/mi)";
    }
  }

  bool get isConsumption => this == FuelEconomyUnit.l100km || this == FuelEconomyUnit.l_mile;

}