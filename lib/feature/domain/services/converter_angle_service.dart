import 'dart:math';
import 'package:convertify/feature/domain/enums/angle_unit.dart';

class ConverterAngleService {
  static const Map<AngleUnit,double> degreeTo = {
   AngleUnit.degree:  1.0,
   AngleUnit.radian: 180 / pi,
   AngleUnit.gradian:  0.9,
   AngleUnit.arcminute: 1 / 60,
   AngleUnit.milliradian: (180 / pi) / 1000,
   AngleUnit.revolution: 360.0,
   AngleUnit.turn: 360.0,
   AngleUnit.quadrant: 90.0,
   AngleUnit.sextant: 60.0
  };

  double convertAngle({
    required double value,
    required AngleUnit from,
    required AngleUnit to,
  }) {
    return (value * degreeTo[from]!) / degreeTo[to]!;
  }
}