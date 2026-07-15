enum VideoUnit {
  mp4, mkv, avi, mov, flv, wmv, webm, m4v, mpeg, threeGp, gif;

  String get ext => '.$name';
  String get label => name.toUpperCase();
  String get subfolder => 'videos';
}