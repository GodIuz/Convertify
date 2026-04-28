import 'package:convertify/feature/domain/enums/energy_unit.dart';

class ConverterEnergyService {
  static const Map<EnergyUnit, double> energyTo ={
    EnergyUnit.joule:  1.0,
    EnergyUnit.kilojoule: 1000.0,
    EnergyUnit.megajoule: 1000000.0,
    EnergyUnit.gigajoule: 1000000000.0,
    EnergyUnit.calorie: 4.184,
    EnergyUnit.kilocalorie: 4184.0,
    EnergyUnit.wh: 3600.0,
    EnergyUnit.kwh: 3600000.0,
    EnergyUnit.mwh: 3600000000.0,
    EnergyUnit.btu: 1055.056,
    EnergyUnit.therm: 105480400.0,
    EnergyUnit.electronvolt: 1.602176634e-19,
    EnergyUnit.erg: 1e-7,
    EnergyUnit.ftlb: 1.35581795,
    EnergyUnit.inlb: 0.11298483,
    EnergyUnit.nm: 1.0
  };

  double convertEnergy({
    required double value,
    required EnergyUnit from,
    required EnergyUnit to,
  }) {
    return (value * energyTo[from]!) / energyTo[to]!;
  }
}