import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/features/auth/bloc/auth_bloc.dart';
import 'package:leetcode_tracker/features/auth/view/email_verification_view.dart';
import 'package:leetcode_tracker/features/auth/view/link_leetcode_view.dart';
import 'package:leetcode_tracker/features/auth/view/login_view.dart';
import 'package:leetcode_tracker/features/auth/view/register_view.dart';
import 'package:leetcode_tracker/features/complete_profile/view/complete_profile_view.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  static const route = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is LoginState) {
              return const Text('Login');
            }
            if (state is RegisterState) {
              return const Text('Register');
            }
            if (state is VerifyEmailState) {
              return const Text('Verify Email');
            }
            return const Text('');
          },
        ),
      ),
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is LoginState) {
              return const LoginView();
            }
            if (state is RegisterState) {
              return const RegisterView();
            }
            if (state is VerifyEmailState) {
              return const VerificationView();
            }
            return const CircularProgressIndicator();
          },
          listener: (context, state) {
            if (state is RegisterState && state.hasErrors) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.errorMessage ?? "",
                ),
                backgroundColor: Colors.red,
              ));
            }

            if (state is LoginState && state.hasErrors) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.errorMessage ?? "",
                ),
                backgroundColor: Colors.red,
              ));
            }

            if (state is AuthDoneState) {
              Navigator.popAndPushNamed(context, CompleteProfileView.route);
            }
          },
        ),
      ),
    );
  }
}
