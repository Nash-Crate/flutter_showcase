part of 'post_card.dart';

/// Post card's claim action.
class PostCardClaim extends StatelessWidget {
  /// constructor
  const PostCardClaim(this.post, {super.key});

  /// The post to claim
  final Post post;

  @override
  Widget build(BuildContext context) {
    return post.videoUrl != null
        ? const SizedBox.shrink()
        : InkWell(
            onTap: () async {
              final claimed = await showDialog<bool>(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text('Claim Post'),
                    content: Text(
                      "Do you want to claim ${post.title} for '${post.price.toStringAsFixed(2)}' points?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(false),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(dialogContext).pop(true),
                        child: const Text('Claim'),
                      ),
                    ],
                  );
                },
              );

              if (claimed == true && context.mounted) {
                final profile = (context.read<AuthCubit>().state as Authenticated).userProfile!;

                // claim the post
                final ppCubit = context.read<PostPurchaseCubit>();
                unawaited(ppCubit.claimPost(post, profile));
              }
            },
            child: Column(
              children: [
                Text(
                  post.price.toStringAsFixed(2),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.shopping_cart,
                  color: Colors.green,
                  size: 16,
                ),
                const Text(
                  'Claim',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
  }
}
