import 'dart:math';
import 'package:totalUnit/feature/domain/enums/frequency_unit.dart';

class ConverterFrequencyService {
  static const Map<FrequencyUnit,double> freqTo ={
   FrequencyUnit.hertz: 1.0,
   FrequencyUnit.kilohertz: 1000.0,
   FrequencyUnit.megahertz: 1000000.0,
   FrequencyUnit.gigahertz: 1000000000.0,
   FrequencyUnit.terahertz: 1000000000000.0,
   FrequencyUnit.rpm: 1 / 60,
   FrequencyUnit.rps: 1.0,
   FrequencyUnit.rad_s: 1 / (2 * pi),
   FrequencyUnit.beats_min: 1 / 60,
   FrequencyUnit.deg_per_sec: 1 / 360,
   FrequencyUnit.rad_per_sec:  1 / (2 * pi)
  };

  double convertFrequency({
    required double value,
    required FrequencyUnit from,
    required FrequencyUnit to,
  }) {
    if (from == to) return value;

    final double hertz = value * freqTo[from]!;

    final double result = hertz / freqTo[to]!;

    return result;
  }


}