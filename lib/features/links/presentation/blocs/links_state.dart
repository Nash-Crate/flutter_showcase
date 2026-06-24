part of 'links_cubit.dart';

/// State of the [LinksCubit]
@freezed
class LinksState with _$LinksState {
  /// Initial state of the [LinksCubit]
  const factory LinksState.initial() = _Initial;

  /// State when a new link is captured by the [LinksCubit]
  const factory LinksState.newLinkCaptured(String link) = NewLinkCaptured;
}
