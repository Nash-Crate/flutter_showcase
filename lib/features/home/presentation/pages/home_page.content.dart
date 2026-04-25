part of 'home_page.dart';

/// The content of the home page.
class HomePageContent extends StatefulWidget {
  /// constructor
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        VideoPlayerController.networkUrl(
            Uri.parse(
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
            ),
          )
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Center(
              child: AnimatedCrossFade(
                firstChild: const Skeletonizer(
                  child: Text('- Video Player -', style: TextStyle(fontSize: 40)),
                ),
                secondChild: BasicVideoPlayer(
                  controller: _controller,
                ),
                crossFadeState: _controller.value.isInitialized
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 100),
              ),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              setState(() {
                _controller.value.isPlaying ? _controller.pause() : _controller.play();
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ],
      ),
    );
  }
}
