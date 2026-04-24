import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';

/// The home page of the app.
class HomePage extends StatelessWidget {
  /// constructor
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final user = (state as Authenticated).userProfile!;

            return Text('Welcome, ${user.name}!');
          },
        ),
      ),
      body: const Center(child: Text('Home')),
    );
  }
}
