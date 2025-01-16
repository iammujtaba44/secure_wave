import 'package:flutter/material.dart';
import 'package:infinite_binary_ui_kit/infinite_binary_ui_kit.dart';
import 'package:secure_wave/core/services/notification_service/model/notification_result.dart';
import 'package:secure_wave/features/notification_detail/widgets/notification_detail_page_description_view.dart';
import 'package:secure_wave/features/notification_detail/widgets/notification_view_widget.dart';
import 'package:secure_wave/features/notification_detail/widgets/video_player_widget.dart';
import 'package:secure_wave/routes/app_routes.dart';
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
            spacing: 10,
            children: [
              NotificationDetailPageDescriptionView(notification: notification),
              if (notification.media != null) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Media',
                    style: context.theme.headlineSmall_F18xW700,
                  ),
                ),
                NotificationViewWidget(
                  child: _buildMediaContent(),
                  padding:
                      notification.isMediaIsText ? const EdgeInsets.only(top: 20) : EdgeInsets.zero,
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
