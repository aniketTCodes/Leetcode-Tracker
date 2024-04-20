import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/auth/bloc/auth_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordContoller;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordContoller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: accentBlack,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Register',
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
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: appYellow,
                )),
                label: Text('Email'),
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
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
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: appYellow,
                )),
                label: Text('Password'),
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              obscureText: true,
              enableSuggestions: false,
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              style: const TextStyle(
                color: appYellow,
              ),
              cursorColor: appYellow,
              controller: _confirmPasswordContoller,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: appYellow,
                )),
                label: Text('Confirm Password'),
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              enableSuggestions: false,
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: FloatingActionButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        RegisterEvent(
                          email: _emailController.text,
                          password: _passwordController.text,
                          confirmPassword: _confirmPasswordContoller.text,
                        ),
                      );
                },
                backgroundColor: appYellow,
                child: const Text(
                  'Register',
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
                    text: "Already have an account? ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  TextSpan(
                      text: 'Login',
                      style: const TextStyle(
                        color: appYellow,
                        fontSize: 16,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.read<AuthBloc>().add(GotoLoginEvent());
                        })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
