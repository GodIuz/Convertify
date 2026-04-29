import 'package:convertify/feature/domain/enums/torque_unit.dart';

class ConverterTorqueService {
  static const Map <TorqueUnit,double> torqueTo = {
   TorqueUnit.nm_torque:  1.0,
   TorqueUnit.knm:  1000.0,
   TorqueUnit.nm_cm: 0.01,
   TorqueUnit.ftlb_torque: 1.3558179483,
   TorqueUnit.inlb_torque:  0.1129848293,
   TorqueUnit.inoz_torque: 0.0070615518,
   TorqueUnit.kgm: 9.80665,
   TorqueUnit.kgcm: 0.0980665
  };

  double convertTorque({
    required double value,
    required TorqueUnit from,
    required TorqueUnit to,
  }) {
    if (from == to) return value;
    return (value * torqueTo[from]!) / torqueTo[to]!;
  }
}