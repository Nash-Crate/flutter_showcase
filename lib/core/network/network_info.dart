import 'dart:async';

import 'package:flutter_showcase/core/errors/errors.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Network info interface
abstract class INetworkInfo {
  /// Stream to listen to network connectivity status changes to connected and disconnected
  Stream<Either<Failure, bool>> get isConnected;
}

/// Network info implementation
@Singleton(as: INetworkInfo)
class NetworkInfoImpl implements INetworkInfo {
  /// constructor
  const NetworkInfoImpl(this._connectivity);

  final InternetConnection _connectivity;

  StreamTransformer<InternetStatus, Either<Failure, bool>> get _isConnectedTransformer {
    return StreamTransformer.fromHandlers(
      handleData: (status, sink) => sink.add(Right(status == InternetStatus.connected)),
      handleError: (dynamic error, stackTrace, sink) {
        sink.add(Left(InfraExceptions.exceptionToFailure(error)));
      },
    );
  }

  @override
  Stream<Either<Failure, bool>> get isConnected =>
      _connectivity.onStatusChange.transform(_isConnectedTransformer);
}
