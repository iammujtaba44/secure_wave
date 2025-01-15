import 'package:flutter/material.dart';
import 'package:infinite_binary_ui_kit/infinite_binary_ui_kit.dart';
import 'package:secure_wave/core/services/notification_service/model/notification_result.dart';
import 'package:secure_wave/features/notification_detail/widgets/notification_detail_page_description_view.dart';
import 'package:secure_wave/features/notification_detail/widgets/notification_view_widget.dart';
import 'package:secure_wave/routes/app_routes.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

@RoutePage()
class NotificationDetailPage extends StatelessWidget {
  final NotificationResult notification;

  const NotificationDetailPage({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.transparent,
        title: Text(
          'Notifications',
          style: context.theme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              NotificationDetailPageDescriptionView(notification: notification),
              if (notification.media != null) ...[
                NotificationViewWidget(
                  child: _buildMediaContent(),
                ),
                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaContent() {
    switch (notification.mediaType) {
      case MediaType.image:
        return CachedNetworkImage(
          imageUrl: notification.media!,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      case MediaType.video:
        return VideoPlayerWidget(videoUrl: notification.media!);
      default:
        return Text(notification.media ?? '');
    }
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_isInitialized)
            VideoPlayer(_controller)
          else
            const Center(child: CircularProgressIndicator()),
          if (_isInitialized)
            IconButton(
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 50,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying ? _controller.pause() : _controller.play();
                });
              },
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
