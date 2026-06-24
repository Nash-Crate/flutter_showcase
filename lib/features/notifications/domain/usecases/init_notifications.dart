import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/notifications/notifications.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Usecase that initializes the notifications system
@singleton
class InitializeNotifications implements UsecaseNoParams<Unit> {
  /// constructor
  const InitializeNotifications(this._repository);

  final INotificationsRepository _repository;

  @override
  AsyncFailT<Unit> call() {
    return _repository.initializeNotifications();
  }
}
