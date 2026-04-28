import 'package:convertify/feature/domain/enums/time_unit.dart';

extension TimeUnitExtension on TimeUnit{
  String get label{
    switch (this){
      case TimeUnit.seconds:
        return "Seconds";
      case TimeUnit.milliseconds:
        return "Milliseconds";
      case TimeUnit.microseconds:
        return "Microseconds";
      case TimeUnit.nanoseconds:
        return "Nanoseconds";
      case TimeUnit.picoseconds:
        return "Picoseconds";
      case TimeUnit.minute:
        return "Minutes";
      case TimeUnit.hour:
        return "Hours";
      case TimeUnit.day:
        return "Days";
      case TimeUnit.week:
        return "Week";
      case TimeUnit.fortnight:
        return "Fortnights";
      case TimeUnit.month:
        return "Months";
      case TimeUnit.quarter:
        return "Quarter";
      case TimeUnit.year:
        return "Years";
      case TimeUnit.decade:
        return "Decades";
      case TimeUnit.century:
        return "Centuries";
      case TimeUnit.millennium:
        return "Millennium";
    }
  }
}