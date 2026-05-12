import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:totalUnit/feature/domain/enums/video_unit.dart';
import 'package:totalUnit/feature/domain/extensions/video_unit_extension.dart';
import 'package:totalUnit/feature/domain/services/video_converter_service.dart';

class ConverterVideoScreen extends StatefulWidget {
  const ConverterVideoScreen({super.key});

  @override
  State<ConverterVideoScreen> createState() => _ConverterVideoScreenState();
}

class _ConverterVideoScreenState extends State<ConverterVideoScreen> {
  final _service = VideoConverterService();

  File? _inputFile;
  VideoUnit _selectedTo = VideoUnit.mp4;

  bool _isConverting = false;
  double _progress = 0.0;
  String? _resultPath;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      setState(() {
        _inputFile = File(result.files.single.path!);
        _resultPath = null;
        _progress = 0.0;
      });
    }
  }

  Future<void> _startConversion() async {
    if (_inputFile == null) return;

    setState(() {
      _isConverting = true;
      _progress = 0.0;
      _resultPath = null;
    });

    try {
      final tempDir = await getTemporaryDirectory();
      final outputFileName = "converted_video_${DateTime.now().millisecondsSinceEpoch}${_selectedTo.extension}";
      final outputPath = "${tempDir.path}/$outputFileName";

      final result = await _service.convertVideo(
        inputFile: _inputFile!,
        targetExtension: _selectedTo.extension,
        outputPath: outputPath,
        onProgress: (val) {
          if (mounted) setState(() => _progress = val);
        },
      );

      if (result != null) {
        setState(() => _resultPath = result);
      } else {
        _showError("Conversion failed. The format might not be supported for this specific video.");
      }
    } catch (e) {
      _showError("An error occurred: $e");
    } finally {
      if (mounted) setState(() => _isConverting = false);
    }
  }

  Future<void> _saveFile() async {
    if (_resultPath == null) return;
    try {
      File file = File(_resultPath!);
      String fileName = _resultPath!.split('/').last;
      String extension = fileName.split('.').last;

      await FileSaver.instance.saveFile(
        name: fileName.replaceAll('.$extension', ''),
        file: file,
        ext: extension,
        mimeType: MimeType.custom,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Video saved successfully!", style: TextStyle(color: Colors.white)), backgroundColor: Colors.green),
      );
    } catch (e) {
      _showError("Failed to save file.");
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: const TextStyle(color: Colors.white)), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFFFD700);
    const bgColor = Color(0xFF0B0B10);
    const cardColor = Color(0xFF1A1A25);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Video Converter", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _isConverting ? null : _pickFile,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _inputFile != null ? goldColor : Colors.white10),
                ),
                child: Column(
                  children: [
                    Icon(
                      _inputFile != null ? Icons.video_file : Icons.upload_file,
                      color: _inputFile != null ? goldColor : Colors.white38,
                      size: 50,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      _inputFile != null ? _inputFile!.path.split('/').last : "Tap to select a video",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _inputFile != null ? Colors.white : Colors.white38,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text("Convert to", style: TextStyle(color: Colors.white38, fontSize: 12)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: goldColor.withOpacity(0.2)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<VideoUnit>(
                  value: _selectedTo,
                  isExpanded: true,
                  dropdownColor: cardColor,
                  icon: const Icon(Icons.keyboard_arrow_down, color: goldColor),
                  items: VideoUnit.values.map((u) {
                    return DropdownMenuItem(
                      value: u,
                      child: Text(u.label, style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: _isConverting ? null : (val) {
                    if (val != null) setState(() => _selectedTo = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            if (_isConverting)
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: CircularProgressIndicator(
                            value: _progress / 100,
                            strokeWidth: 8,
                            backgroundColor: Colors.white10,
                            color: goldColor,
                          ),
                        ),
                        Text(
                          "${_progress.toStringAsFixed(1)}%",
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text("Converting... Please wait", style: TextStyle(color: goldColor, fontSize: 12)),
                  ],
                ),
              )
            else if (_resultPath != null)
              Center(
                child: Column(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 60),
                    const SizedBox(height: 10),
                    const Text("Conversion Complete!", style: TextStyle(color: Colors.white, fontSize: 16)),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: _saveFile,
                        icon: const Icon(Icons.save_alt, color: bgColor),
                        label: const Text("SAVE VIDEO", style: TextStyle(color: bgColor, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: goldColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _inputFile == null ? null : _startConversion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _inputFile == null ? Colors.white10 : goldColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: Text(
                    "CONVERT",
                    style: TextStyle(
                      color: _inputFile == null ? Colors.white38 : bgColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}