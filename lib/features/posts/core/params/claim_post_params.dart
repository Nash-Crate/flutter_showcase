import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim_post_params.freezed.dart';

/// Parameters for claiming a post
@freezed
abstract class ClaimPostParams with _$ClaimPostParams {
  /// constructor
  const factory ClaimPostParams({required int postId, required int userProfileId}) =
      _ClaimPostParams;
}
