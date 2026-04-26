import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/profile_selection/profile_selection.dart';

/// Page for selecting the profile for the user
/// This page will be shown after the user has logged in and will allow the user to select a profile to use for the app
class ProfileSelectionPage extends StatelessWidget {
  /// constructor
  const ProfileSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a profile'),
      ),
      body: BlocBuilder<ProfileSelectionCubit, ProfileSelectionState>(
        builder: (context, state) {
          if (state.profiles == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: state.profiles!.length,
            itemBuilder: (context, index) {
              final profile = state.profiles![index];
              return ListTile(
                tileColor: Colors.grey,
                title: Text(profile.name),
                onTap: () async {
                  // unawaited(context.read<HomeCubit>().fetchRecentWatchHistory());
                  // unawaited(context.read<DiscoveryCubit>().fetchDiscoveries());

                  unawaited(context.read<ProfileSelectionCubit>().selectProfile(profile));
                  HomeRoute().pushReplacement(context);
                },
              );
            },
          );
        },
      ),
    );
  }
}
