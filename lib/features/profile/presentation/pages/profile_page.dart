import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/profile/profile.dart';
import 'package:flutter_showcase/features/purchases/purchases.dart';
import 'package:flutter_showcase/injection.dart';

/// The profile page of the app.
class ProfilePage extends StatefulWidget {
  /// constructor
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCoinsCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: BlocSelector<AuthCubit, AuthState, UserProfile?>(
                selector: (state) {
                  if (state is Authenticated) {
                    return state.userProfile;
                  }
                  return null;
                },
                builder: (context, profile) {
                  return Text(profile?.name ?? '...');
                },
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Confirm Logout'),
                          content: const Text('Are you sure you want to log out?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('No'),
                            ),
                          ],
                        );
                      },
                    );
                    if (confirmed ?? false) {
                      if (context.mounted) unawaited(context.read<AuthCubit>().signOut());
                    }
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            body: Column(
              spacing: 20,
              children: [
                // coins balance
                BlocSelector<ProfileCoinsCubit, ProfileCoinsState, double>(
                  selector: (state) => state.coins,
                  builder: (context, coins) {
                    return Column(
                      children: [
                        Text('Coins Balance: ', style: Theme.of(context).textTheme.bodyMedium),
                        Text.rich(
                          TextSpan(
                            text: '',
                            style: Theme.of(context).textTheme.bodySmall,

                            children: [
                              TextSpan(
                                text: coins.toStringAsFixed(2),
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // TextSpan(
                              //   text: r' NC$',
                              //   style: Theme.of(context).textTheme.bodySmall,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),

                // purchase coins
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text('Purchase Coins'),
                      onPressed: () async {
                        await showModalBottomSheet<void>(
                          context: context,
                          builder: (context) => const PurchaseCoinsBottomSheet(),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
