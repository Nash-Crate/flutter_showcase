part of 'posts_page.dart';

/// The content of the posts page.
class PostsPageContent extends StatelessWidget {
  /// constructor
  const PostsPageContent({required this.scrollController, super.key});

  /// The scroll controller for the posts list.
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state.error != null) {
          return Center(child: Text('Error: ${state.error}'));
        }

        if (state.initialized && state.posts.isEmpty) {
          return const Center(child: Text('No posts found.'));
        }

        return Skeletonizer(
          enabled: !state.initialized,
          child: ListView.builder(
            controller: scrollController,
            itemCount: state.initialized ? state.posts.length : 10,
            itemBuilder: (context, index) {
              final post = state.initialized ? state.posts.values.toList()[index] : Post.empty();

              return BlocProvider(
                create: (context) => getIt<PostPurchaseCubit>(param1: post),
                child: PostCard(post, key: ValueKey(post.id)),
              );
            },
          ),
        );
      },
    );
  }
}
