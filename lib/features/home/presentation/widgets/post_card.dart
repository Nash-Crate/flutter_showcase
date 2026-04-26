import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/logger.dart';
// import 'package:skeletonizer/skeletonizer.dart';
import 'package:video_player/video_player.dart';

/// A card widget to display a post.
class PostCard extends StatefulWidget {
  /// constructor
  const PostCard(this.post, {super.key});

  /// The post to display
  final Post post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.post.videoUrl))
      // ..addListener(_onControllerUpdate)
      ..initialize()
          .then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          })
          .onError(
            (error, stackTrace) async {
              logger.e(error);
              showErrorNotification('Error loading video: $error');
            },
          );
  }

  @override
  void dispose() {
    // _controller.removeListener(_onControllerUpdate);
    unawaited(_controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Card(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    BasicVideoPlayer(controller: _controller),

                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                        width: constrains.maxWidth,
                        child: VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true, // enables seeking
                        ),
                      ),
                    ),

                    ValueListenableBuilder(
                      valueListenable: _controller,
                      builder: (context, value, child) {
                        return Positioned(
                          bottom: 4,
                          right: 4,
                          child: Text(
                            '${value.position.inMinutes}:${value.position.inSeconds.toString().padLeft(2, '0')} / ${value.duration.inMinutes}:${value.duration.inSeconds.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // const SizedBox(height: 10),
              TextButton(
                onPressed: () async {
                  await (_controller.value.isPlaying ? _controller.pause() : _controller.play());
                  setState(() {});
                },
                child: ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (context, value, child) {
                    return Icon(value.isPlaying ? Icons.pause : Icons.play_arrow);
                  },
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
