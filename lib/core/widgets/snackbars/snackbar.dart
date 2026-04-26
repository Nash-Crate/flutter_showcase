import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// Clear snackbars
void clearAllNotifications() => toastification.dismissAll();

/// Clear snackbar by id
void dismissNotificationById(String id) => toastification.dismissById(id);

/// Clear grouped snackbars
// void clearAllGroupNotifications(String groupKey) => BotToast.removeAll(groupKey);

/// Error snackbar
void showErrorNotification(String msg) {
  toastification.show(
    title: Text(msg),
    primaryColor: Colors.redAccent,
    autoCloseDuration: const Duration(seconds: 30),
    // animationDuration: const Duration(seconds: 30),
    // animationBuilder: (context, animation, alignment, child) {
    //   return RotationTransition(
    //     turns: animation,
    //     child: child,
    //   );
    // },
  );
}

/// Success snackbar
void showSuccessNotification(String msg) {
  toastification.show(
    title: Text(msg),
    primaryColor: Colors.greenAccent,
    autoCloseDuration: const Duration(seconds: 5),
    // animationDuration: const Duration(seconds: 5),
    // animationBuilder: (context, animation, alignment, child) {
    //   return RotationTransition(
    //     turns: animation,
    //     child: child,
    //   );
    // },
  );
}

/// Info snackbar
void showInfoNotification(String msg) {
  toastification.show(
    title: Text(msg),
    primaryColor: Colors.blueAccent,
    autoCloseDuration: const Duration(seconds: 5),
    // animationDuration: const Duration(seconds: 5),
    // animationBuilder: (context, animation, alignment, child) {
    //   return RotationTransition(
    //     turns: animation,
    //     child: child,
    //   );
    // },
  );
}
