import 'package:totalUnit/feature/domain/enums/video_unit.dart';

extension VideoUnitExtension on VideoUnit {
  String get label {
    if (this == VideoUnit.gp3) return "3GP";
    return name.toUpperCase();
  }

  String get extension {
    if (this == VideoUnit.gp3) return ".3gp";
    return ".${name.toLowerCase()}";
  }
}