import 'package:totalUnit/feature/domain/enums/electric_unit.dart';

extension ElectricUnitExtension on ElectricUnit{
  String get label{
    switch(this){
      case ElectricUnit.ampere:
        return "Ampere (A)";
      case ElectricUnit.milliampere:
        return "Milliampere (mA)";
      case ElectricUnit.microampere:
        return "Microampere (μA)";
      case ElectricUnit.volt:
        return "Volt (V)";
      case ElectricUnit.millivolt:
        return "Millivolt (mV)";
      case ElectricUnit.kilovolt:
        return "Kilovolt (kV)";
      case ElectricUnit.ohm:
        return "Ohm (Ω)";
      case ElectricUnit.kilohm:
        return "Kilohm (kΩ)";
      case ElectricUnit.megohm:
        return "Megohm (MΩ)";
      case ElectricUnit.farad:
        return "Farad (F)";
      case ElectricUnit.microfarad:
        return "Microfarad (μF)";
      case ElectricUnit.nanofarad:
        return "Nanofarad  (nF)";
      case ElectricUnit.picofarad:
        return "Picofarad (pF)";
      case ElectricUnit.henry:
        return "Henry(H)";
      case ElectricUnit.millihenry:
        return "Millihenry (mH)";
      case ElectricUnit.coulomb:
        return "Coulomb (C)";
      case ElectricUnit.ah:
        return "Ampere-hour (Ah)";
      case ElectricUnit.mah:
        return "Milliampere-hour (mAh)";
    }
  }

  String get group {
    if (label.contains('A')) return 'current';
    if (label.contains('V')) return 'voltage';
    if (label.contains('Ω')) return 'resistance';
    if (label.contains('F')) return 'capacitance';
    if (label.contains('H')) return 'inductance';
    return 'charge';
  }
}