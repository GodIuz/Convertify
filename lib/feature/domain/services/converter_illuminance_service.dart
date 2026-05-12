import 'package:totalUnit/feature/domain/enums/illuminance_unit.dart';

class ConverterIlluminanceService {
  static const Map<IlluminanceUnit, double> illuminanceTO = {
    IlluminanceUnit.lux: 1.0,
    IlluminanceUnit.footcandle: 10.76391,
    IlluminanceUnit.phot: 10000.0,
    IlluminanceUnit.nit: 3.14159, // Προσέγγιση Lambertian surface (1 nit ≈ π lux)
    IlluminanceUnit.lumen: 1.0,   // Θεωρώντας ομοιόμορφο φωτισμό σε 1 m²
  };

  double convert(double value, IlluminanceUnit from, IlluminanceUnit to) {
    if (from == to) return value;
    return (value * illuminanceTO[from]!) / illuminanceTO[to]!;
  }

  String formatResult(double value) {
    if (value == 0) return "0";
    if (value.abs() < 0.001 || value.abs() > 999999) {
      return value.toStringAsExponential(4);
    }
    return double.parse(value.toStringAsFixed(4)).toString();
  }
}