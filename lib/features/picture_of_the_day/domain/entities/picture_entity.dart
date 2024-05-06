class PictureEntity {
  const PictureEntity({
    required this.url,
    required this.title,
    required this.date,
    required this.isVideo,
  });

  final Uri url;
  final String title;
  final DateTime date;
  final bool isVideo;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is PictureEntity &&
        other.url == url &&
        other.title == title &&
        other.date == date &&
        other.isVideo == isVideo;
  }

  @override
  int get hashCode {
    return url.hashCode ^ title.hashCode ^ date.hashCode ^ isVideo.hashCode;
  }
}
