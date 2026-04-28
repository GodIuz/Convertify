import '../enums/angle_unit.dart';

extension AngleUnitExtension on AngleUnit{
  String get label{
    switch(this){
      case AngleUnit.degree:
        return "Degree (°)";
      case AngleUnit.radian:
        return "Radian (rad)";
      case AngleUnit.gradian:
        return "Gradian (grad)";
      case AngleUnit.arcminute:
        return "Arcminute (')";
      case AngleUnit.milliradian:
        return "Milliradian (\")";
      case AngleUnit.revolution:
        return "Revolution (rev)";
      case AngleUnit.turn:
        return "Turn (tr)";
      case AngleUnit.quadrant:
        return "Quadrant (quad)";
      case AngleUnit.sextant:
        return "Sextant (sxt)";
    }
  }
}