import 'package:freezed_annotation/freezed_annotation.dart';

part 'cache_failures.freezed.dart';

/// Base class for all [CacheFailure]s
@freezed
abstract class CacheFailure with _$CacheFailure {
  /// Cache clear failure
  const factory CacheFailure.cacheClearFailure({String? message}) = CacheClearFailure;

  /// Cache set failure
  const factory CacheFailure.cacheSetFailure({String? message}) = CacheSetFailure;

  /// Cache get failure
  const factory CacheFailure.cacheGetFailure({String? message}) = CacheGetFailure;
}
