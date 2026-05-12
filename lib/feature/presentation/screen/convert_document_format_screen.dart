import 'package:totalUnit/feature/domain/enums/document_format.dart';
import 'package:totalUnit/feature/domain/extensions/document_format_extension.dart';
import 'package:totalUnit/feature/domain/services/document_converter_engine.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';

class ConverterDocumentFormatScreen extends StatefulWidget {
  const ConverterDocumentFormatScreen({super.key});

  @override
  State<ConverterDocumentFormatScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterDocumentFormatScreen> {
  PlatformFile? _selectedFile;
  DocumentFormat _targetFormat = DocumentFormat.pdf;
  bool _isProcessing = false;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['docx'],
      withData: true,
    );
    if (result != null) setState(() => _selectedFile = result.files.first);
  }

  Future<void> _runConversion() async {
    if (_selectedFile == null || _selectedFile!.bytes == null) return;
    setState(() => _isProcessing = true);

    try {
      final universalDoc = DocumentConverterEngine.parseDocx(_selectedFile!.bytes!);
      final resultBytes = await DocumentConverterEngine.convert(universalDoc, _targetFormat);

      await FileSaver.instance.saveFile(
        name: "\${_selectedFile!.name.split('.').first}_converted",
        bytes: resultBytes,
        ext: _targetFormat.ext,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Conversion Successful!')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: \$e')));
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CONVERTIFY")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: _pickFile,
                child: Text(_selectedFile?.name ?? "Pick DOCX File")
            ),
            if (_selectedFile != null) ...[
              const SizedBox(height: 20),
              const Text("Select Target Format:"),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: DocumentFormat.values
                    .where((f) => f != DocumentFormat.docx)
                    .map((f) {
                  return ChoiceChip(
                    label: Text(f.label),
                    selected: _targetFormat == f,
                    onSelected: (_) => setState(() => _targetFormat = f),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isProcessing ? null : _runConversion,
                child: _isProcessing
                    ? const CircularProgressIndicator()
                    : const Text("Convert and Save"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}