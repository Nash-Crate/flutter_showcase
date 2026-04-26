part of 'home_page.dart';

/// The content of the home page.
class HomePageContent extends StatefulWidget {
  /// constructor
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // skeleton loading state
        if (!state.initialized) {
          return Skeletonizer(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return PostCard(
                  Post(id: '$index', title: 'Post $index', videoUrl: ''),
                  key: ValueKey('skeleton_$index'),
                );
              },
            ),
          );
        }

        if (state.posts.isEmpty) {
          return const Center(child: Text('No posts found.'));
        }

        return ListView.builder(
          itemCount: state.posts.length,
          itemBuilder: (context, index) {
            final post = state.posts[index];

            return PostCard(post, key: ValueKey(post.id));
          },
        );
      },
    );
  }
}
