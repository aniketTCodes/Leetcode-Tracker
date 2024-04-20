import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/complete_profile/bloc/bloc/complete_profile_bloc.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/service/leetcode_service.dart';
import 'package:leetcode_tracker/features/auth/bloc/auth_bloc.dart';
import 'package:leetcode_tracker/features/auth/view/auth_view.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  late TextEditingController _leetcodeIdController;
  late TextEditingController _displayNameController;

  @override
  void initState() {
    _leetcodeIdController = TextEditingController();
    _displayNameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: matteBlack,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Card(
            color: accentBlack,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Link Leetcode',
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
                      color: Colors.white,
                    ),
                    controller: _leetcodeIdController,
                    cursorColor: appYellow,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        color: appYellow,
                      ),
                      labelText: 'Tell us your leetcode username',
                      border: OutlineInputBorder(),
                      focusColor: appYellow,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: appYellow,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    controller: _displayNameController,
                    cursorColor: appYellow,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: appYellow),
                      labelText: 'What should we call you?',
                      border: OutlineInputBorder(),
                      focusColor: appYellow,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: appYellow,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FloatingActionButton(
                      onPressed: () {
                        context.read<CompleteProfileBloc>().add(
                            CompleteProfileSaveEvent(
                                username: _displayNameController.text,
                                displayName: _leetcodeIdController.text));
                      },
                      backgroundColor: appYellow,
                      child: const Text('Continue'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Not your account? ",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        TextSpan(
                            text: 'Log out',
                            style: const TextStyle(
                              color: appYellow,
                              fontSize: 16,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.read<AuthBloc>().add(LogoutEvent());
                                Navigator.of(context)
                                    .popAndPushNamed(AuthView.route);
                              })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
