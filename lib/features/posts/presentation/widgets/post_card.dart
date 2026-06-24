import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/posts/posts.dart';
import 'package:flutter_showcase/features/purchases/purchases.dart';
import 'package:flutter_showcase/logger.dart';
import 'package:video_player/video_player.dart';

part 'post_card.claim.dart';
part 'post_card.media.image.dart';
part 'post_card.media.video.dart';

/// A card widget to display a post.
class PostCard extends StatefulWidget {
  /// constructor
  const PostCard(this.post, {super.key});

  /// The post to display
  final Post post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<PostPurchaseCubit>(context),
      child: Builder(
        builder: (context) {
          return BlocListener<PostPurchaseCubit, PostPurchaseState>(
            listenWhen: (prev, cur) =>
                prev.isPostClaimed != cur.isPostClaimed || prev.error != cur.error,
            listener: (context, state) async {
              if (state.isPostClaimed) {
                // Update the posts list from the purchased cubit post
                context.read<PostsCubit>().postClaimed(state.post);

                // Show success notification
                showSuccessNotification('Post claimed successfully!');
              }
            },
            child: LayoutBuilder(
              builder: (context, constrains) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cover media
                      if (widget.post.videoUrl != null)
                        PostCardMediaVideo(post: widget.post, constrains: constrains)
                      else
                        PostCardMediaImage(post: widget.post, constrains: constrains),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Post title
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.post.title,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                if (widget.post.videoUrl != null)
                                  InkWell(
                                    onTap: () {
                                      PostDetailRoute(id: widget.post.id.toString()).go(context);
                                    },
                                    child: const Text(
                                      'View Post',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            const Spacer(),

                            // Claim widget
                            BlocSelector<
                              PostPurchaseCubit,
                              PostPurchaseState,
                              PostPurchaseProcessingState
                            >(
                              selector: (state) => state.processingState,
                              builder: (context, processingState) {
                                return SizedBox(
                                  height: 40,
                                  child: switch (processingState) {
                                    PostPurchaseProcessingState.claiming => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    PostPurchaseProcessingState.idle => PostCardClaim(widget.post),
                                    PostPurchaseProcessingState.claimed => PostCardClaim(
                                      widget.post,
                                    ),
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
