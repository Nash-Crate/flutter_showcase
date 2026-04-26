import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

/// A simple Post model representing a video post in the app.
@freezed
abstract class Post with _$Post {
  /// constructor
  const factory Post({
    required int id,
    required String title,
    required String description,
    required String thumbnailImage,
    required double price,
    required int purchasesCount,
    String? videoUrl,
  }) = _Post;

  const Post._();

  /// empty post for skeleton loading
  factory Post.empty() => const Post(
    id: 0,
    title: '',
    description: '',
    thumbnailImage: 'https://picsum.photos/200',
    price: 0,
    purchasesCount: 0,
  );
}
