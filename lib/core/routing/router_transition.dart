part of 'router.dart';

CustomTransitionPage<T> _buildSlideTransitionPage<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  required AxisDirection direction, // left or right
}) {
  assert(
    direction == AxisDirection.left || direction == AxisDirection.right,
    'Only left and right directions are supported for slide transitions.',
  );

  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    // transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final begin = switch (direction) {
        AxisDirection.left => const Offset(1, 0), // slide in from right
        AxisDirection.right => const Offset(-1, 0), // slide in from left
        _ => Offset.zero,
      };

      return SlideTransition(
        position: Tween(
          begin: begin,
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
        child: child,
      );
    },
  );
}
