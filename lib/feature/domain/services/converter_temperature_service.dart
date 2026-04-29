import 'package:convertify/feature/domain/enums/temperature_unit.dart';

class ConverterTemperatureService {
  double convertTemperature({
    required double value,
    required TemperatureUnit from,
    required TemperatureUnit to,
  }) {
    if (from == to) return value;

    double celsius;
    switch (from) {
      case TemperatureUnit.celsius:
        celsius = value;
        break;
      case TemperatureUnit.fahrenheit:
        celsius = (value - 32) * 5 / 9;
        break;
      case TemperatureUnit.kelvin:
        celsius = value - 273.15;
        break;
      case TemperatureUnit.rankine:
        celsius = (value - 491.67) * 5 / 9;
        break;
      case TemperatureUnit.reaumur:
        celsius = value * 1.25;
        break;
      case TemperatureUnit.delisle:
        celsius = 100 - (value * 2 / 3);
        break;
      case TemperatureUnit.newton:
        celsius = value * 100 / 33;
        break;
      case TemperatureUnit.romer:
        celsius = (value - 7.5) * 40 / 21;
        break;
    }

    switch (to) {
      case TemperatureUnit.celsius:
        return celsius;
      case TemperatureUnit.fahrenheit:
        return (celsius * 9 / 5) + 32;
      case TemperatureUnit.kelvin:
        return celsius + 273.15;
      case TemperatureUnit.rankine:
        return (celsius + 273.15) * 9 / 5;
      case TemperatureUnit.reaumur:
        return celsius * 0.8;
      case TemperatureUnit.delisle:
        return (100 - celsius) * 3 / 2;
      case TemperatureUnit.newton:
        return celsius * 33 / 100;
      case TemperatureUnit.romer:
        return (celsius * 21 / 40) + 7.5;
    }
  }
}