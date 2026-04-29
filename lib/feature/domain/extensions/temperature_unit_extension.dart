import '../enums/temperature_unit.dart';

extension TemperatureUnitExtension on TemperatureUnit {
  String get label {
    switch (this) {
      case TemperatureUnit.celsius: return "Celsius (°C)";
      case TemperatureUnit.fahrenheit: return "Fahrenheit (°F)";
      case TemperatureUnit.kelvin: return "Kelvin (K)";
      case TemperatureUnit.rankine: return "Rankine (°R)";
      case TemperatureUnit.reaumur: return "Réaumur (°Ré)";
      case TemperatureUnit.delisle: return "Delisle (°De)";
      case TemperatureUnit.newton: return "Newton (°N)";
      case TemperatureUnit.romer: return "Rømer (°Rø)";
    }
  }
}