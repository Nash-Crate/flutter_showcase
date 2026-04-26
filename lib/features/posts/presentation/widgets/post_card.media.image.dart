part of 'post_card.dart';

/// A widget to display the image media of a post.
class PostCardMediaImage extends StatelessWidget {
  /// constructor
  const PostCardMediaImage({required this.post, required this.constrains, super.key});

  /// size constrains for the media container
  final BoxConstraints constrains;

  /// The post to display
  final Post post;

  @override
  Widget build(BuildContext context) {
    // media height aspect ratio of the screen width
    final mediaHeight = constrains.maxWidth * 9 / 16;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      child: Image.network(
        post.thumbnailImage,
        width: double.infinity,
        height: mediaHeight,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          logger.e('${post.id}: $error');
          return Container(
            width: double.infinity,
            height: mediaHeight,
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
          );
        },
      ),
    );
  }
}
