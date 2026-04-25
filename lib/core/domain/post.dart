import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

/// A simple Post model representing a video post in the app.
@freezed
abstract class Post with _$Post {
  /// constructor
  const factory Post({
    required String id,
    required String title,
    required String videoUrl,
  }) = _Post;
}
