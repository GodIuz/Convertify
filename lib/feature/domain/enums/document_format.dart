enum DocumentFormat{
docx,
doc,
pdf,
txt,
rtf,
odt,
md;

String get ext => '.$name';
String get label => name.toUpperCase();
String get subfolder => 'documents';
}