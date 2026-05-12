enum AudioFormat {
  mp3,
  wav,
  aac,
  m4a,
  ogg,
  flac;

  String get ext => name;
  String get label => name.toUpperCase();
}