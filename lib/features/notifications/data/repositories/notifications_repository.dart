import 'package:flutter_showcase/core/types/type_defs.dart';
import 'package:flutter_showcase/features/notifications/notifications.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Concrete implementation of the [INotificationsRepository] interface that provides methods for managing notifications.
@Singleton(as: INotificationsRepository)
class NotificationsRepository implements INotificationsRepository {
  /// constructor
  const NotificationsRepository(this._datasource);

  final NotificationsDatasource _datasource;

  @override
  AsyncFailT<Unit> initializeNotifications() {
    return _datasource.initializeNotifications();
  }
}
