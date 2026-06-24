import 'package:flutter/foundation.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/notifications/notifications.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

/// Abstract class that defines the interface for the notifications data source
abstract class NotificationsDatasource with INotificationsRepository {}

/// Implementation of the [NotificationsDatasource] interface
@Singleton(as: NotificationsDatasource)
class NotificationsDatasourceImpl implements NotificationsDatasource {
  @override
  AsyncFailT<Unit> initializeNotifications() async {
    try {
      // Enable verbose logging for debugging
      if (kDebugMode) await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

      // OneSignal App ID
      await OneSignal.initialize(const String.fromEnvironment('ONE_SIGNAL_APP_ID'));

      // Use this method to prompt for push notifications.
      // We recommend removing this method after testing and instead use In-App Messages to prompt for notification permission.
      await OneSignal.Notifications.requestPermission(false);

      return const Right(unit);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }
}
