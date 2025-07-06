class VideoInfo {
  final String title;
  final String duration;
  final String thumbnailUrl;
  final String videoUrl;

  VideoInfo({
    required this.title,
    required this.duration,
    required this.thumbnailUrl,
    required this.videoUrl,
  });

  factory VideoInfo.fromJson(Map<String, dynamic> json) {
    return VideoInfo(
      title: json['title'],
      duration: json['duration'].toString(),
      thumbnailUrl: json['thumbnail'],
      videoUrl: json['videoUrl'],
    );
  }
}
