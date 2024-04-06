import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/features/auth/bloc/auth_bloc.dart';
import 'package:leetcode_tracker/features/auth/view/auth_view.dart';

class HomeView extends StatelessWidget {
  static const route = '/home';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton.filled(
              onPressed: () {
                context.read<AuthBloc>().add(LogoutEvent());
                Navigator.of(context).popAndPushNamed(AuthView.route);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.yellow,
              ))
        ],
      ),
    );
  }
}
