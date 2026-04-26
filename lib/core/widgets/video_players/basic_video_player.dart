import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Basic Video player widget
class BasicVideoPlayer extends StatelessWidget {
  /// constructor
  const BasicVideoPlayer({required this.controller, super.key});

  /// Video player controller
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            )
          : Container(),
    );
  }
}
