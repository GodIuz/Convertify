import 'package:convertify/feature/domain/enums/document_format.dart';

extension DocumentFormatExtension on DocumentFormat{
  String get label{
    switch(this){
      case DocumentFormat.pdf:
        return "PDF (.pdf)";
      case DocumentFormat.docx:
        return "Word (.docx)";
      case DocumentFormat.xlsx:
        return "Excel (.xlsx)";
      case DocumentFormat.pptx:
        return "PowerPoint (.pptx)";
      case DocumentFormat.txt:
        return "Text (.txt)";
      case DocumentFormat.html:
        return "HTML (.html)";
      case DocumentFormat.odt:
        return "OpenDocument (.odt)";
    }
  }
}