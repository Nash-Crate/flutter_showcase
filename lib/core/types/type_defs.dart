import 'package:flutter_showcase/core/core.dart';
import 'package:fpdart/fpdart.dart';

/// Type alias for a function that returns a Future of [Either<Failure, T>]
typedef AsyncFailT<T> = Future<EitherF<T>>;

/// Type alias for a function that returns a Future of [Either<Failure, T>]
typedef EitherF<T> = Either<Failure, T>;

/// Type alias for a function that returns a Stream of [Either<Failure, T>]
typedef StreamFailT<T> = Stream<Either<Failure, T>>;

/// Type alias for a function that returns a Stream of [Either<Failure, T>]
typedef FailT<T> = EitherF<T>;
