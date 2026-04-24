import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

/// Clear snackbars
void clearAllNotifications() => BotToast.cleanAll();

/// Clear grouped snackbars
void clearAllGroupNotifications(String groupKey) => BotToast.removeAll(groupKey);

/// Error snackbar
void showErrorNotification(String msg, {String? groupKey}) {
  BotToast.showSimpleNotification(
    title: msg,
    backgroundColor: Colors.redAccent,
    duration: const Duration(seconds: 30),
    // titleStyle: context.primaryTextTheme.titleSmall,
    // TODO(temp): ?.copyWith(color: AppColors.white),
    crossPage: true,
    hideCloseButton: false,
  );
}

/// Success snackbar
void showSuccessNotification(String msg) {
  BotToast.showSimpleNotification(
    title: msg,
    backgroundColor: Colors.greenAccent,
    duration: const Duration(seconds: 5),
    // titleStyle: Theme.of(context).textTheme.titleSmall,
    // TODO(temp): ?.copyWith(color: AppColors.white),
    crossPage: true,
    hideCloseButton: false,
  );
}

/// Info snackbar
void showInfoNotification(String msg) {
  BotToast.showSimpleNotification(
    title: msg,
    backgroundColor: Colors.blueAccent,
    duration: const Duration(seconds: 5),
    // titleStyle: Theme.of(context).textTheme.titleSmall,
    // TODO(temp): ?.copyWith(color: AppColors.white),
    hideCloseButton: false,
  );
}
