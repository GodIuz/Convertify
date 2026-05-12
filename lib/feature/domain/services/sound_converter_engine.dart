import 'dart:io';
import 'package:totalUnit/feature/domain/enums/audio_format.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
import 'package:path_provider/path_provider.dart';

class SoundConverterEngine {
  static Future<File?> convertAudio({
    required File inputFile,
    required AudioFormat targetFormat,
  }) async {
    final directory = await getTemporaryDirectory();
    final String inputPath = inputFile.path;
    final String outputPath = '${directory.path}/converted_audio.${targetFormat.ext}';
    final outputFile = File(outputPath);
    if (outputFile.existsSync()) await outputFile.delete();
    final String ffmpegCommand = '-i "$inputPath" "$outputPath"';
    final session = await FFmpegKit.execute(ffmpegCommand);
    final returnCode = await session.getReturnCode();
    if (ReturnCode.isSuccess(returnCode)) {
      return outputFile;
    } else if (ReturnCode.isCancel(returnCode)) {
      throw Exception("Conversion cancelled");
    } else {
      throw Exception("Conversion failed. Check file format compatibility.");
    }
  }
}