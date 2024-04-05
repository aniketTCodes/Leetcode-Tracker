import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  void initState() {
    _leetcodeIdController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'Complete Profile',
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogoutEvent());
                Navigator.of(context).popAndPushNamed(AuthView.route);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _leetcodeIdController,
              cursorColor: Colors.yellow,
              decoration: const InputDecoration(
                labelText: 'Tell us your leetcode username',
                border: OutlineInputBorder(),
                focusColor: Colors.yellow,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Color.fromARGB(
                      255,
                      251,
                      230,
                      1,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
