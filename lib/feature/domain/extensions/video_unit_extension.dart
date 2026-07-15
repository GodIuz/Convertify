import 'package:totalUnit/feature/domain/enums/video_unit.dart';

extension VideoUnitExtension on VideoUnit {
  String get label {
    switch (this) {
      case VideoUnit.avi: return 'AVI';
      case VideoUnit.mp4: return 'MP4';
      default: return 'AVI';
    }
  }

  String get extension {
    switch (this) {
      case VideoUnit.avi: return '.avi';
      case VideoUnit.mp4: return '.mp4';
      default: return '.avi';
    }
  }
}