
import 'package:convertify/feature/domain/enums/document_format.dart';

extension DocumentFormatExtension on DocumentFormat {
  String get ext {
    switch (this) {
      case DocumentFormat.docx: return 'docx';
      case DocumentFormat.doc:  return 'doc';
      case DocumentFormat.pdf:  return 'pdf';
      case DocumentFormat.txt:  return 'txt';
      case DocumentFormat.rtf:  return 'rtf';
      case DocumentFormat.odt:  return 'odt';
      case DocumentFormat.md:   return 'md';
    }
  }

  String get label => ext.toUpperCase();
}