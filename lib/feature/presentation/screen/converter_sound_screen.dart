import 'dart:io';
import 'package:totalUnit/feature/domain/enums/audio_format.dart';
import 'package:totalUnit/feature/domain/services/sound_converter_engine.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';

class ConverterSoundScreen extends StatefulWidget {
  const ConverterSoundScreen({super.key});

  @override
  State<ConverterSoundScreen> createState() => _ConverterSoundScreenState();
}

class _ConverterSoundScreenState extends State<ConverterSoundScreen> {
  File? _selectedFile;
  AudioFormat _targetFormat = AudioFormat.mp3;
  bool _isProcessing = false;

  Future<void> _pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (result != null) {
      setState(() => _selectedFile = File(result.files.single.path!));
    }
  }

  Future<void> _runConversion() async {
    if (_selectedFile == null) return;
    setState(() => _isProcessing = true);

    try {
      final convertedFile = await SoundConverterEngine.convertAudio(
        inputFile: _selectedFile!,
        targetFormat: _targetFormat,
      );

      if (convertedFile != null) {
        final bytes = await convertedFile.readAsBytes();
        await FileSaver.instance.saveFile(
          name: "converted_audio",
          bytes: bytes,
          ext: _targetFormat.ext,
        );

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Success! Audio Saved.")),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(title: const Text("SOUND CONVERTER"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickAudio,
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.redAccent.withValues(alpha: 0.5)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.music_note, color: Colors.redAccent, size: 50),
                    const SizedBox(height: 10),
                    Text(_selectedFile != null
                        ? _selectedFile!.path.split('/').last
                        : "SELECT AUDIO FILE"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (_selectedFile != null) ...[
              const Text("TARGET FORMAT"),
              const SizedBox(height: 15),
              Wrap(
                spacing: 8,
                children: AudioFormat.values.map((format) {
                  return ChoiceChip(
                    label: Text(format.label),
                    selected: _targetFormat == format,
                    onSelected: (_) => setState(() => _targetFormat = format),
                    selectedColor: Colors.redAccent,
                  );
                }).toList(),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                  onPressed: _isProcessing ? null : _runConversion,
                  child: _isProcessing
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("CONVERT NOW", style: TextStyle(color: Colors.white)),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}