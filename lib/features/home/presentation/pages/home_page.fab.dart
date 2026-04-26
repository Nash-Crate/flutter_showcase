part of 'home_page.dart';

/// The floating action button of the home page.
class HomePageFab extends StatelessWidget {
  /// constructor
  const HomePageFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Add new Post',
      onPressed: () {
        showInfoNotification('FAB pressed!');
      },
      child: const Icon(Icons.add),
    );
  }
}
