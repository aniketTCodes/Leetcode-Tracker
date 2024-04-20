import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/auth/bloc/auth_bloc.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 60,
          ),
          const Text(
            'Verify your email',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'NotoSerif',
              fontSize: 28,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Click the verify email button to get a verification email on your email ID',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: FloatingActionButton(
                backgroundColor: appYellow,
                onPressed: () {
                  context.read<AuthBloc>().add(SendVerificationEvent());
                },
                child: const Text('Verify Email'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
