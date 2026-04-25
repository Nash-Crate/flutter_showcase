import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/logger.dart';
import 'package:go_router/go_router.dart';

/// The home page of the app.
class HomePage extends StatelessWidget {
  /// constructor
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.pushReplacement(SignInRoute().location);
        }
      },
      builder: (context, state) {
        if (state is! Authenticated || state.userProfile == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final user = (state as Authenticated).userProfile!;

                return Text('Welcome, ${user.name}!');
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  child: const Icon(Icons.logout),
                  onTap: () async {
                    await showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: context.read<AuthCubit>().signOut,
                            child: const Text('Logout', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          body: const Center(child: Text('Home')),
        );
      },
    );
  }
}
