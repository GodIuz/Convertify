import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:flutter/foundation.dart';

class VideoConverterService {
  Future<String?> convertVideo({
    required File inputFile,
    required String targetExtension,
    required String outputPath,
    required Function(double) onProgress,
  }) async {
    final inputPath = inputFile.path;
    int totalDurationInMs = 0;
    final mediaInfoSession = await FFprobeKit.getMediaInformation(inputPath);
    final mediaInfo = mediaInfoSession.getMediaInformation();

    if (mediaInfo != null && mediaInfo.getDuration() != null) {
      final durationString = mediaInfo.getDuration()!;
      totalDurationInMs = (double.parse(durationString) * 1000).toInt();
    }

    String command;
    if (targetExtension.toLowerCase() == '.gif') {
      command = "-i '$inputPath' -vf 'fps=15,scale=480:-1:flags=lanczos' -c:v gif '$outputPath'";
    } else {
      command = "-i '$inputPath' -c:v copy -c:a copy '$outputPath'";
    }

    final session = await FFmpegKit.executeAsync(command,
            (session) async {
          // Τερματισμός (Επιτυχία ή Αποτυχία)
        },
            (log) {
          // Logs (δεν τα χρειαζόμαστε εδώ)
        },
            (statistics) {
          if (totalDurationInMs > 0) {
            final timeInMs = statistics.getTime();
            double progress = (timeInMs / totalDurationInMs) * 100;
            if (progress > 100) progress = 100.0;
            if (progress < 0) progress = 0.0;
            onProgress(progress);
          }
        }
    );

    await session.getState();
    final returnCode = await session.getReturnCode();

    if (ReturnCode.isSuccess(returnCode)) {
      onProgress(100.0);
      return outputPath;
    } else {
      if (kDebugMode) {
        print("FFmpeg Error: ${await session.getFailStackTrace()}");
      }
      return null;
    }
  }
}