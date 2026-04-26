import 'package:flutter_showcase/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

/// Post model
@freezed
abstract class PostModel with _$PostModel {
  /// Constructor
  const factory PostModel({
    required int id,
    required String title,
    required String description,
    @JsonKey(name: 'thumbnail_image') required String thumbnailImage,
    required double price,
    @JsonKey(name: 'purchases_count') required int purchasesCount,
    @JsonKey(name: 'video_url') String? videoUrl,
  }) = _PostModel;

  /// from json
  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  const PostModel._();

  /// Convert to domain model
  Post toDomain() {
    return Post(
      id: id,
      title: title,
      description: description,
      thumbnailImage: thumbnailImage,
      price: price,
      purchasesCount: purchasesCount,
      videoUrl: videoUrl,
    );
  }
}
