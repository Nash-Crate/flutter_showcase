import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/notifications/notifications.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'notifications_state.dart';

part 'notifications_cubit.freezed.dart';

/// Cubit that manages the state of notifications in the application.
@singleton
class NotificationsCubit extends Cubit<NotificationsState> {
  /// constructor
  NotificationsCubit(this._initializeNotifications) : super(const NotificationsState.initial()) {
    unawaited(_init());
  }

  final InitializeNotifications _initializeNotifications;

  Future<void> _init() async {
    final res = await _initializeNotifications();

    if (res.isLeft()) addError(res.asL);
  }
}
