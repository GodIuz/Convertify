import 'package:file_picker/file_picker.dart';
import 'package:gal/gal.dart';
import 'package:totalUnit/feature/domain/enums/image_format.dart';
import 'package:totalUnit/feature/domain/extensions/image_format_extension.dart';
import 'package:totalUnit/feature/domain/services/converter_image_format_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterImageScreen extends StatefulWidget {
  const ConverterImageScreen({super.key});

  @override
  State<ConverterImageScreen> createState() => _ConverterImageScreenState();
}

class _ConverterImageScreenState extends State<ConverterImageScreen> {
  final _converterService = ConverterImageFormatService();

  ImageFormat targetFormat = ImageFormat.png;
  bool isProcessing = false;
  String? fileName;
  Uint8List? pickedFileBytes;

  void _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null) {
      setState(() {
        fileName = result.files.first.name;
        pickedFileBytes = result.files.first.bytes;
      });
    }
  }

  void _convert() async {
    if (pickedFileBytes == null || fileName == null) return;

    setState(() => isProcessing = true);

    try {
      final Uint8List? result = await _converterService.convertImage(
          pickedFileBytes!,
          targetFormat
      );

      if (result != null) {
        String pureName = fileName!;
        if (pureName.contains('.')) {
          pureName = pureName.substring(0, pureName.lastIndexOf('.'));
        }

        final String finalFileName = pureName;

        await Gal.putImageBytes(
          result,
          name: finalFileName,
        );

        HapticFeedback.heavyImpact();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Success! Saved as $finalFileName"),
              backgroundColor: Colors.green.withValues(alpha: 0.8),
            ),
          );
        }
      } else {
        throw Exception("Conversion failed.");
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${e.toString()}"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const imagePink = Color(0xFFE91E63);
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Image Converter",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Source File", style: TextStyle(color: Colors.white38, fontSize: 12)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: imagePink.withValues(alpha: 0.2),
                      style: BorderStyle.solid),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.cloud_upload_outlined, color: imagePink, size: 48),
                    const SizedBox(height: 12),
                    Text(fileName ?? "Tap to upload image",
                        style: TextStyle(
                            color: fileName != null ? Colors.white : Colors.white24,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Text("Convert to:", style: TextStyle(color: Colors.white54, fontSize: 14)),
                const SizedBox(width: 15),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<ImageFormat>(
                        value: targetFormat,
                        isExpanded: true,
                        dropdownColor: const Color(0xFF1A1A25),
                        items: ImageFormat.values.map((f) => DropdownMenuItem(
                          value: f,
                          child: Text(f.label, style: const TextStyle(color: Colors.white, fontSize: 14)),
                        )).toList(),
                        onChanged: (val) => setState(() => targetFormat = val!),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: fileName != null && !isProcessing ? _convert : null,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: fileName != null
                        ? [imagePink, const Color(0xFFC2185B)]
                        : [Colors.grey.shade900, Colors.black],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: fileName != null ? [
                    BoxShadow(color: imagePink.withValues(alpha: 0.3), blurRadius: 15, spreadRadius: 2)
                  ] : [],
                ),
                child: Center(
                  child: isProcessing
                      ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : Text(
                    fileName != null ? "CONVERT NOW" : "SELECT AN IMAGE FIRST",
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Center(child: Text("CONVERTIFY v1.0", style: TextStyle(color: Colors.white10, fontSize: 10))),
          ],
        ),
      ),
    );
  }
}