import 'dart:developer';

class NotificationResult {
  final String title;
  final String message;
  final String? media;
  final MediaType mediaType;
  final String? notificationId;
  final Map<String, dynamic>? data;

  NotificationResult({
    required this.title,
    required this.message,
    this.media,
    this.mediaType = MediaType.text,
    this.notificationId,
    this.data,
  });

  factory NotificationResult.fromJson(Map<String, dynamic> json) {
    return NotificationResult(
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      media: json['media'] ?? null,
      mediaType: MediaType.fromJson(json['media_type'] ?? 'text'),
      notificationId: json['notificationId'] ?? null,
      data: json['data'] ?? null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'media': media,
      'media_type': mediaType.name,
      'notificationId': notificationId,
      'data': data,
    };
  }

  bool get isMediaIsText => mediaType == MediaType.text;
}

enum MediaType {
  text,
  image,
  video,
  audio;

  factory MediaType.fromJson(String json) {
    return MediaType.values.firstWhere(
      (e) => e.name == json,
      orElse: () => MediaType.text,
    );
  }
}
