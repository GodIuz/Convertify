import 'package:convertify/feature/domain/enums/pressure_unit.dart';

extension PressureUnitExtension on PressureUnit{
  String get label{
    switch(this){
      case PressureUnit.pascal:
        return "Pascal (Pa)";
      case PressureUnit.kilopascal:
        return "Kilopascal (kPa)";
      case PressureUnit.gigapascal:
        return "Gigapascal (GPa)";
      case PressureUnit.hectopascal:
        return "Hectopascal (hPa)";
      case PressureUnit.barye:
        return "Barye (Ba)";
      case PressureUnit.bar:
        return "Bar";
      case PressureUnit.mbar:
        return "Millibar (mbar)";
      case PressureUnit.atmTech:
        return "Technical Atmosphere (at)";
      case PressureUnit.atm:
        return "Standard Atmosphere (atm)";
      case PressureUnit.psi:
        return "Pounds per sq inch (psi)";
      case PressureUnit.psf:
        return "Pounds per sq foot (psf)";
      case PressureUnit.tonsPerSqInch:
        return "Tons per sq inch";
      case PressureUnit.tonsPerSqFoot:
        return "Tons per sq foot";
      case PressureUnit.ksi:
        return "Kilopounds per sq inch (ksi)";
      case PressureUnit.cmHg:
        return "cm of Mercury (cmHg)";
      case PressureUnit.mmH2O:
        return "mm of Water (mmH₂O)";
      case PressureUnit.cmH2O:
        return "cm of Water (cmH₂O)";
      case PressureUnit.ftH2O:
        return "ft of Water (ftH₂O)";
      case PressureUnit.mH2O:
        return "m of Water (mH₂O)";
      case PressureUnit.pieze:
        return "Pièze (pz)";
      case PressureUnit.sthenePerSqMeter:
        return "Sthene per sq meter (sn/m²)";
      case PressureUnit.gfPerSqCm:
        return "Gram-force per sq cm (gf/cm²)";
      case PressureUnit.mmHg:
        return "mm of Mercury (mmHg)";
      case PressureUnit.inHg:
        return "Inches of Mercury (inHg)";
      case PressureUnit.torr:
        return "Torr";
      case PressureUnit.dynePerCm2:
        return "Dyne per sq cm (dyn/cm²)";
    }
  }
}