import 'dart:async';

import 'package:flutter/material.dart';
import 'package:secure_wave/core/theme/app_colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> with RouteAware {
  late VideoPlayerController videoPlayerController;
  bool hasVideoInitialized = false;
  bool _showControls = false;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        hasVideoInitialized = true;
        videoPlayerController.setVolume(100);
        videoPlayerController.setLooping(true);
        videoPlayerController.play();
        setState(() {});
      });
  }

  void _handleControlsVisibility() {
    if (_hideTimer?.isActive ?? false) {
      _hideTimer!.cancel();
    }

    setState(() {
      _showControls = true;
    });

    _hideTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted && videoPlayerController.value.isPlaying) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _ = videoPlayerController.value.aspectRatio;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: GestureDetector(
        onTap: _handleControlsVisibility,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (videoPlayerController.value.isInitialized)
              Builder(builder: (__) {
                return FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  child: SizedBox(
                    height: videoPlayerController.value.size.height,
                    width: videoPlayerController.value.size.width,
                    child: VideoPlayer(
                      videoPlayerController,
                    ),
                  ),
                );
              })
            else
              SizedBox(
                height: height * 0.2,
                width: width,
                child: Center(child: CircularProgressIndicator()),
              ),
            if (videoPlayerController.value.isInitialized && _showControls)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.black,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 50,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      if (videoPlayerController.value.isPlaying) {
                        videoPlayerController.pause();
                        _showControls = true;
                        _hideTimer?.cancel();
                      } else {
                        videoPlayerController.play();
                        _handleControlsVisibility();
                      }
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
