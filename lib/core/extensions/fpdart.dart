import 'package:fpdart/fpdart.dart';

/// Centralized [Either] and [Option] extensions
extension EitherX<L, R> on Either<L, R> {
  /// Get the value from [Either]
  R get asR => (this as Right<L, R>).value;

  /// Get the value from [Either]
  L get asL => (this as Left<L, R>).value;
}

/// Centralized [Option] extensions
extension OptionX<T> on Option<T> {
  /// Get the value from [Option]
  T get asSome => fold(() => throw Exception('None!'), (value) => value);
}
