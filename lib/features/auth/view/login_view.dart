import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/auth/bloc/auth_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Card(
        color: accentBlack,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'NotoSerif',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                style: const TextStyle(
                  color: appYellow,
                ),
                cursorColor: appYellow,
                controller: _emailController,
                decoration: const InputDecoration(
                  label: Text('Email'),
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appYellow,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                style: const TextStyle(
                  color: appYellow,
                ),
                cursorColor: appYellow,
                controller: _passwordController,
                decoration: const InputDecoration(
                    label: Text('Password'),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: appYellow,
                    ))),
                obscureText: true,
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: FloatingActionButton(
                  backgroundColor: appYellow,
                  onPressed: () {
                    context.read<AuthBloc>().add(LoginEvent(
                        email: _emailController.text,
                        password: _passwordController.text));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    TextSpan(
                        text: 'Register',
                        style: const TextStyle(
                          color: appYellow,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.read<AuthBloc>().add(GotoRegisterEvent());
                          })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
