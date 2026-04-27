
import 'package:convertify/feature/domain/enums/time_unit.dart';

class ConverterTimeService {

  static const Map<TimeUnit , double> toBaseValue = {
   TimeUnit.picoseconds: 1e-12,
   TimeUnit.nanoseconds: 1e-9,
   TimeUnit.microseconds: 1e-6,
   TimeUnit.milliseconds: 0.001,
   TimeUnit.seconds: 1.0,
   TimeUnit.minute: 60.0,
   TimeUnit.hour: 3600.0,
   TimeUnit.day: 86400.0,
   TimeUnit.week: 604800.0,
   TimeUnit.fortnight: 1209600.0,
   TimeUnit.month: 2629746.0,
   TimeUnit.quarter: 7889238.0,
   TimeUnit.year: 31557600.0,
   TimeUnit.decade: 315576000.0,
   TimeUnit.century: 3155760000.0,
   TimeUnit.millennium: 31557600000.0
  };

  double convertTime({
    required double value,
    required TimeUnit from,
    required TimeUnit to,
  }) {
    double seconds = value * toBaseValue[from]!;
    return seconds / toBaseValue[to]!;
  }
}