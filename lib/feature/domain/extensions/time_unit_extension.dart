import 'package:convertify/feature/domain/enums/time_unit.dart';

extension TimeUnitExtension on TimeUnit{
  String get label{
    switch (this){
      case TimeUnit.seconds:
        return "Seconds (s)";
      case TimeUnit.milliseconds:
        return "Milliseconds (ms)";
      case TimeUnit.microseconds:
        return "Microseconds (μs)";
      case TimeUnit.nanoseconds:
        return "Nanoseconds (ns)";
      case TimeUnit.picoseconds:
        return "Picoseconds (ps)";
      case TimeUnit.minute:
        return "Minutes (m)";
      case TimeUnit.hour:
        return "Hours (h)";
      case TimeUnit.day:
        return "Days (d)";
      case TimeUnit.week:
        return "Week (d)";
      case TimeUnit.fortnight:
        return "Fortnights (fn)";
      case TimeUnit.month:
        return "Months (mo)";
      case TimeUnit.quarter:
        return "Quarter (qtr)";
      case TimeUnit.year:
        return "Years (yr)";
      case TimeUnit.decade:
        return "Decades (dec)";
      case TimeUnit.century:
        return "Centuries (c)";
      case TimeUnit.millennium:
        return "Millennium (mil)";
    }
  }
}