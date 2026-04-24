import 'package:flutter/material.dart';

/// A sheet that allows the user to select a profile.
class UserProfileSelectionSheet extends StatelessWidget {
  /// constructor
  const UserProfileSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        color: const Color(0xFFE0E0E0),
        child: Column(
          spacing: 10,
          children: [
            SizedBox(
              height: 60,
              child: Center(
                child: Text('Select a profile', style: Theme.of(context).textTheme.headlineSmall),
              ),
            ),

            SizedBox(
              height: (MediaQuery.of(context).size.height * 0.8) - 70,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFBDBDBD),
                      child: Text('User ${index + 1}'),
                    ),
                    title: Text('User ${index + 1}'),
                    onTap: () {
                      // Handle profile selection
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
