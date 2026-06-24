import 'package:flutter/material.dart';

/// The post details page.
class PostDetailsPage extends StatelessWidget {
  /// constructor
  const PostDetailsPage({required this.id, super.key});

  /// The ID of the post to display.
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Details')),
      body: Center(
        child: Text('Post ID: $id'),
      ),
    );
  }
}
