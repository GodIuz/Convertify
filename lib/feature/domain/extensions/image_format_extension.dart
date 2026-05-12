import 'package:totalUnit/feature/domain/enums/image_format.dart';

extension ImageFormatExtension on ImageFormat{
  String get label{
    switch(this){
      case ImageFormat.jpg: return "JPEG (.jpg)";
      case ImageFormat.png: return "PNG (.png)";
      case ImageFormat.webp: return "WebP (.webp)";
      case ImageFormat.gif: return "GIF (.gif)";
      case ImageFormat.bmp: return "BMP (.bmp)";
      case ImageFormat.tiff: return "TIFF (.tiff)";
    }
  }

  String get extension => name;
}