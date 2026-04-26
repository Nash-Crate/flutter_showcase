import 'package:flutter/material.dart';

/// App elevated button widget
class AppElevatedButton extends StatelessWidget {
  /// Creates an elevated button with default properties.
  const AppElevatedButton({
    required this.isLoading,
    required this.label,
    super.key,
    this.onPressed,
  });

  /// label of the button
  final String label;

  /// Callback function when the button is pressed
  final VoidCallback? onPressed;

  /// isLoading flag to show loading state
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          child: Text(label),
        ),

        if (isLoading)
          const Positioned.fill(
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
