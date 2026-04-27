import 'package:convertify/feature/domain/enums/pressure_unit.dart';

class ConverterPressureService {
  static const Map<PressureUnit,double> pressureTo ={
    PressureUnit.pascal: 1,
    PressureUnit.kilopascal: 1000.0,
    PressureUnit.gigapascal: 1e9,
    PressureUnit.hectopascal: 100.0,
    PressureUnit.barye: 0.1,
    PressureUnit.bar: 100000.0,
    PressureUnit.mbar: 100.0,
    PressureUnit.atmTech: 98066.5,
    PressureUnit.atm: 101325.0,
    PressureUnit.psi: 6894.75729,
    PressureUnit.psf: 47.8802589,
    PressureUnit.tonsPerSqInch: 13789514.6,
    PressureUnit.tonsPerSqFoot: 95760.518,
    PressureUnit.ksi: 6894757.29,
    PressureUnit.cmHg: 1333.22,
    PressureUnit.mmH2O: 9.80665,
    PressureUnit.cmH2O: 98.0665,
    PressureUnit.ftH2O: 2989.067,
    PressureUnit.mH2O: 9806.65,
    PressureUnit.pieze: 1000.0,
    PressureUnit.sthenePerSqMeter: 1000.0,
    PressureUnit.gfPerSqCm: 98.0665,
    PressureUnit.mmHg: 133.322,
    PressureUnit.inHg: 3386.388,
    PressureUnit.torr: 133.322368,
    PressureUnit.dynePerCm2: 0.1
  };

  double convertPressure({
    required double value,
    required PressureUnit from,
    required PressureUnit to}) {
    final double pressure = value / pressureTo[from]!;
    final double convertedPressure = pressure /pressureTo[to]!;
    return convertedPressure;
  }

}