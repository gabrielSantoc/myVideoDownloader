class VideoFormat {
  final String resolution;
  final String extension;
  final String type;
  final String? filesize;
  
  VideoFormat({
    required this.resolution,
    required this.extension,
    required this.type,
    this.filesize,
  });

  factory VideoFormat.fromJson(Map<String, dynamic> json) {
    return VideoFormat(
      resolution: json['resolution'] ?? 'unknown',
      extension: json['ext'] ?? 'unknown',
      type: json['type'] ?? 'unknown',
      filesize: json['filesize'] ?? 'unknown',
    );
  }

  static List<VideoFormat> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => VideoFormat.fromJson(json)).toList();
  }

}