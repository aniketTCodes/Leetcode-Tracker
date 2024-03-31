import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/features/auth/bloc/auth_bloc.dart';


class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verify your email to continue',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: FloatingActionButton(
            onPressed: () {
              context.read<AuthBloc>().add(SendVerificationEvent());
            },
            child: const Text('Send email verification'),
          ),
        )
      ],
    );
  }
}
