class VideoInfo {
  final String title;
  final String duration;
  final String thumbnailUrl;

  VideoInfo({
    required this.title,
    required this.duration,
    required this.thumbnailUrl,
  });


  factory VideoInfo.fromJson(Map<String, dynamic> json) {
    return VideoInfo(
      title: json['title'],
      duration: json['duration'].toString(),
      thumbnailUrl: json['thumbnail']
    );
  }
}
