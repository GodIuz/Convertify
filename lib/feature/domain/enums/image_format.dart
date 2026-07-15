enum ImageFormat {
  jpg,
  png,
  webp,
  gif,
  bmp,
  tiff;

  String get ext => '.$name';
  String get label => name.toUpperCase();
  String get subfolder => 'images';
}