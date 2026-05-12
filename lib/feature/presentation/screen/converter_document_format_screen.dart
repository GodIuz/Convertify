import 'package:totalUnit/feature/domain/enums/document_format.dart';
import 'package:totalUnit/feature/domain/extensions/document_format_extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterDocumentFormatScreen extends StatefulWidget {
  const ConverterDocumentFormatScreen({super.key});

  @override
  State<ConverterDocumentFormatScreen> createState() => _ConverterDocumentFormatScreenState();
}

class _ConverterDocumentFormatScreenState extends State<ConverterDocumentFormatScreen> {
  final _cloudConvert = ConverterDocService();

  DocumentFormat targetFormat = DocumentFormat.pdf;
  bool isProcessing = false;
  String? fileName;
  Uint8List? pickedFileBytes;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      withData: true,
    );

    if (result != null) {
      setState(() {
        fileName = result.files.first.name;
        pickedFileBytes = result.files.first.bytes;
      });
    }
  }

  void _startConversion() async {
    if (pickedFileBytes == null || fileName == null) return;

    setState(() => isProcessing = true);

    try {
      final result = await _cloudConvert.convertDocument(
        fileBytes: pickedFileBytes!,
        fileName: fileName!,
        targetFormat: targetFormat.name,
      );

      if (result != null) {
        String pureName = fileName!.split('.').first;
        await FileSaver.instance.saveFile(
          name: pureName,
          bytes: result,
          ext: targetFormat.name,
        );

        HapticFeedback.heavyImpact();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Success! Saved as ${targetFormat.name}"), backgroundColor: Colors.green),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.redAccent),
        );
      }
    } finally {
      if (mounted) setState(() => isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFFE91E63);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(title: const Text("Universal Converter"), centerTitle: true, backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Step 1: Select Document", style: TextStyle(color: Colors.white54)),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickFile,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 50),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: accentColor.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.upload_file, color: accentColor, size: 40),
                    const SizedBox(height: 10),
                    Text(fileName ?? "Tap to pick a document", style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text("Step 2: Convert To", style: TextStyle(color: Colors.white54)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<DocumentFormat>(
                  value: targetFormat,
                  isExpanded: true,
                  dropdownColor: const Color(0xFF1A1A25),
                  icon: const Icon(Icons.arrow_drop_down, color: accentColor),
                  items: DocumentFormat.values.map((f) => DropdownMenuItem(
                    value: f,
                    child: Text(f.label, style: const TextStyle(color: Colors.white)),
                  )).toList(),
                  onChanged: (val) => setState(() => targetFormat = val!),
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: (fileName != null && !isProcessing) ? _startConversion : null,
                child: isProcessing
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("START CONVERSION", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}