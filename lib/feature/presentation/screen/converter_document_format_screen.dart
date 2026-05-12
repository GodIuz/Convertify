import 'package:totalUnit/feature/domain/enums/document_format.dart';
import 'package:totalUnit/feature/domain/extensions/document_format_extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:totalUnit/feature/domain/services/document_converter_engine.dart';

class ConverterDocumentFormatScreen extends StatefulWidget {
  const ConverterDocumentFormatScreen({super.key});

  @override
  State<ConverterDocumentFormatScreen> createState() => _ConverterDocumentFormatScreenState();
}

class _ConverterDocumentFormatScreenState extends State<ConverterDocumentFormatScreen> {

  DocumentFormat targetFormat = DocumentFormat.pdf;
  bool isProcessing = false;
  String? fileName;
  Uint8List? pickedFileBytes;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['docx'],
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
      final universalDoc = DocumentConverterEngine.parseDocx(pickedFileBytes!);
      final result = await DocumentConverterEngine.convert(universalDoc, targetFormat);

      if (result != null) {
        String pureName = fileName!.split('.').first;
        await FileSaver.instance.saveFile(
          name: "${pureName}_converted",
          bytes: result,
          ext: targetFormat.ext,
        );

        HapticFeedback.heavyImpact();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Success! Saved locally as ${targetFormat.label}"),
                backgroundColor: Colors.green
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Local Conversion Error: $e"),
              backgroundColor: Colors.redAccent
          ),
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
      appBar: AppBar(
        title: const Text("Document Converter"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Step 1: Select .DOCX File", style: TextStyle(color: Colors.white54)),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickFile,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 50),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: accentColor.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.description, color: accentColor, size: 40),
                    const SizedBox(height: 10),
                    Text(
                      fileName ?? "Tap to pick a Word document",
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text("Step 2: Target Format", style: TextStyle(color: Colors.white54)),
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
                  items: DocumentFormat.values
                      .where((f) => f != DocumentFormat.docx) // Μην μετατρέπεις docx σε docx
                      .map((f) => DropdownMenuItem(
                    value: f,
                    child: Text(f.label, style: const TextStyle(color: Colors.white)),
                  )).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => targetFormat = val);
                  },
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
                  disabledBackgroundColor: Colors.white10,
                ),
                onPressed: (fileName != null && !isProcessing) ? _startConversion : null,
                child: isProcessing
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("CONVERT", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "TOTAL UNIT v1.0",
                style: TextStyle(color: Colors.white24, fontSize: 11),
              ),
            )
          ],
        ),
      ),
    );
  }
}