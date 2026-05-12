import 'dart:convert';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:convertify/feature/domain/enums/document_format.dart';
import 'package:convertify/feature/domain/services/doc_element.dart';
import 'package:convertify/feature/domain/services/universal_doc.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:xml/xml.dart';

class DocumentConverterEngine {
  static UniversalDoc parseDocx(Uint8List bytes) {
    final archive = ZipDecoder().decodeBytes(bytes);
    final docFile = archive.findFile('word/document.xml');
    if (docFile == null) throw Exception("Invalid DOCX");

    final document = XmlDocument.parse(utf8.decode(docFile.content));
    final universal = UniversalDoc();

    for (var node in document.findAllElements('w:r')) {
      final text = node.findAllElements('w:t').map((e) => e.innerText).join();
      final isBold = node.findAllElements('w:b').isNotEmpty;
      if (text.isNotEmpty) {
        universal.elements.add(DocElement(text, isBold: isBold));
      }
    }
    return universal;
  }

  static Future<Uint8List> convert(UniversalDoc doc, DocumentFormat target) async {
    switch (target) {
      case DocumentFormat.pdf:
        return await _toPdf(doc);
      case DocumentFormat.odt:
        return _toOdt(doc);
      case DocumentFormat.md:
        return Uint8List.fromList(utf8.encode(_toMd(doc)));
      case DocumentFormat.rtf:
        return Uint8List.fromList(utf8.encode(_toRtf(doc)));
      case DocumentFormat.doc:
        return Uint8List.fromList(utf8.encode(_toRtf(doc)));
      case DocumentFormat.txt:
        final plainText = doc.elements.map((e) => e.text).join(" ");
        return Uint8List.fromList(utf8.encode(plainText));
      default:
        throw Exception("Unsupported format");
    }
  }

  static Future<Uint8List> _toPdf(UniversalDoc doc) async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: doc.elements.map((e) => pw.Text(
            e.text,
            style: pw.TextStyle(fontWeight: e.isBold ? pw.FontWeight.bold : pw.FontWeight.normal)
        )).toList(),
      ),
    ));
    return pdf.save();
  }

  static Uint8List _toOdt(UniversalDoc doc) {
    final archive = Archive();
    final buffer = StringBuffer();
    buffer.write('<?xml version="1.0" encoding="UTF-8"?>');
    buffer.write('<office:document-content xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0">');
    buffer.write('<office:body><office:text>');

    for (var e in doc.elements) {
      buffer.write('<text:p>${e.text}</text:p>');
    }

    buffer.write('</office:text></office:body></office:document-content>');

    archive.addFile(ArchiveFile('content.xml', buffer.length, utf8.encode(buffer.toString())));
    archive.addFile(ArchiveFile('mimetype', 39, utf8.encode('application/vnd.oasis.opendocument.text')));

    return Uint8List.fromList(ZipEncoder().encode(archive)!);
  }

  static String _toMd(UniversalDoc doc) {
    return doc.elements.map((e) => e.isBold ? "**${e.text}**" : e.text).join(" ");
  }

  static String _toRtf(UniversalDoc doc) {
    StringBuffer rtf = StringBuffer(r'{\rtf1\ansi\deff0 ');
    for (var e in doc.elements) {
      if (e.isBold) rtf.write(r'\b ');
      rtf.write(e.text);
      if (e.isBold) rtf.write(r'\b0 ');
      rtf.write(r'\line ');
    }
    rtf.write('}');
    return rtf.toString();
  }
}