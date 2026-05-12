import 'package:totalUnit/feature/domain/enums/electric_unit.dart';
import 'package:totalUnit/feature/domain/extensions/electric_unit_extension.dart';

class ConverterElectricService {
  static const Map<ElectricUnit,double> electricalTo ={
    ElectricUnit.ampere: 1.0,
    ElectricUnit.milliampere: 1000.0,
    ElectricUnit.microampere: 1000000.0,
    ElectricUnit.volt: 1.0,
    ElectricUnit.millivolt: 1000.0,
    ElectricUnit.kilovolt: 0.001,
    ElectricUnit.ohm: 1.0,
    ElectricUnit.kilohm: 0.001,
    ElectricUnit.megohm: 0.000001,
    ElectricUnit.farad: 1.0,
    ElectricUnit.microfarad: 1000000.0,
    ElectricUnit.nanofarad: 1000000000.0,
    ElectricUnit.picofarad: 1000000000000.0,
    ElectricUnit.henry: 1.0,
    ElectricUnit.millihenry: 1000.0,
    ElectricUnit.coulomb: 1.0,
    ElectricUnit.ah: 1/3600,
    ElectricUnit.mah: 1000/3600,
  };

  double convertElectric({
    required double value,
    required ElectricUnit from,
    required ElectricUnit to,
  }) {
    if (from.group != to.group) return 0.0;
    double baseValue = value / electricalTo[from]!;
    return baseValue * electricalTo[to]!;
  }
}