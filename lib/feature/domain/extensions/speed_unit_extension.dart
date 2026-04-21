import 'package:convertify/feature/domain/enums/speed_unit.dart';

extension SpeedUnitExtensions on SpeedUnit{
  String get label {
    switch(this){
      case SpeedUnit.ms: return "Meters per second (m/s)";
      case SpeedUnit.kmh: return "Kilometers per hour (km/h)";
      case SpeedUnit.kms: return "Kilometers per second (km/s)";
      case SpeedUnit.mph: return "Miles per hour (mph)";
      case SpeedUnit.fts: return "Feet per second (ft/s)";
      case SpeedUnit.ins: return "Inches per second (in/s)";
      case SpeedUnit.knots: return "Knots";
      case SpeedUnit.mach: return "Mach";
      case SpeedUnit.speedlight: return "Speed of Light";
      case SpeedUnit.cms: return "Centimeters per second (cm/s)";
      case SpeedUnit.mms: return "Millimeter per seconds (mm/s)";
      case SpeedUnit.ftm: return "Foot per minute (ft/m)";
    }
  }
}