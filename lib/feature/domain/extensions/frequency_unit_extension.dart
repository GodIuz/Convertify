import 'package:totalUnit/feature/domain/enums/frequency_unit.dart';

extension FrequencyUnitExtension on FrequencyUnit {
  String get label {
    switch (this) {
      case FrequencyUnit.hertz:
        return "Hertz (Hz)";
      case FrequencyUnit.kilohertz:
        return "Kilohertz (kHz)";
      case FrequencyUnit.megahertz:
        return "Megahertz (MHz)";
      case FrequencyUnit.gigahertz:
        return "Gigahertz (GHz)";
      case FrequencyUnit.terahertz:
        return "Terahertz (THz)";
      case FrequencyUnit.rpm:
        return "Revolutions per min (RPM)";
      case FrequencyUnit.rps:
        return "Revolutions per sec (RPS)";
      case FrequencyUnit.rad_s:
        return "Radians per sec (rad/s)";
      case FrequencyUnit.beats_min:
        return "Beats per minute (BPM)";
      case FrequencyUnit.deg_per_sec:
        return "Degrees per sec (°/s)";
      case FrequencyUnit.rad_per_sec:
        return "Radians per sec (Alternate)";
    }
  }
}