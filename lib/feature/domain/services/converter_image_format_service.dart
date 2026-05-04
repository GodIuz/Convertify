import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;
import '../enums/image_format.dart';

class ConverterImageFormatService {
  Future<Uint8List?> convertImage(Uint8List inputBytes, ImageFormat targetFormat) async {

    if (targetFormat == ImageFormat.webp) {
      return await convertToWebP(inputBytes);
    }

    img.Image? image = img.decodeImage(inputBytes);
    if (image == null) return null;

    switch (targetFormat) {
      case ImageFormat.jpg:
        return img.encodeJpg(image);
      case ImageFormat.png:
        return img.encodePng(image);
      case ImageFormat.gif:
        return img.encodeGif(image);
      case ImageFormat.bmp:
        return img.encodeBmp(image);
      case ImageFormat.tiff:
        return img.encodeTiff(image);
      default:
        return null;
    }
  }

  Future<Uint8List?> convertToWebP(Uint8List inputBytes) async {
    var result = await FlutterImageCompress.compressWithList(
      inputBytes,
      format: CompressFormat.webp,
      quality: 80,
    );
    return result;
  }
}