part of 'post_card.dart';

/// A widget to display the video media of a post.
class PostCardMediaVideo extends StatefulWidget {
  /// constructor
  const PostCardMediaVideo({required this.post, required this.constrains, super.key});

  /// size constrains for the media container
  final BoxConstraints constrains;

  /// The post to display
  final Post post;

  @override
  State<PostCardMediaVideo> createState() => _PostCardMediaVideoState();
}

class _PostCardMediaVideoState extends State<PostCardMediaVideo> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    if (widget.post.videoUrl != null) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.post.videoUrl!))
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
  }

  @override
  void dispose() {
    // _controller.removeListener(_onControllerUpdate);
    unawaited(_controller?.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // media height aspect ratio of the screen width
    final mediaHeight = widget.constrains.maxWidth * 9 / 16;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      child: SizedBox(
        height: mediaHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            BasicVideoPlayer(controller: _controller!),

            // play/pause icon
            Positioned(
              bottom: 2,
              left: -2,
              child: SizedBox(
                height: 20,
                width: 20,
                child: ValueListenableBuilder(
                  valueListenable: _controller!,
                  builder: (context, value, child) {
                    return Icon(
                      value.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 15,
                    );
                  },
                ),
              ),
            ),

            // transparent layer to detect taps for play/pause
            Positioned.fill(
              bottom: 10,
              child: InkWell(
                onTap: () async {
                  await (_controller!.value.isPlaying ? _controller!.pause() : _controller!.play());
                  // setState(() {});
                },
              ),
            ),

            // video progress indicator with scrubbing
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: widget.constrains.maxWidth,
                child: VideoProgressIndicator(
                  _controller!,
                  allowScrubbing: true, // enables seeking
                ),
              ),
            ),

            // video position and duration
            ValueListenableBuilder(
              valueListenable: _controller!,
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
    );
  }
}
