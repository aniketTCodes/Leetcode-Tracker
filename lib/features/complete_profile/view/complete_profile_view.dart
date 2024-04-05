import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/features/complete_profile/bloc/bloc/complete_profile_bloc.dart';
import 'package:leetcode_tracker/features/complete_profile/view/complete_profile.dart';

class CompleteProfileView extends StatelessWidget {
  static const route = '/completeProfile';
  const CompleteProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CompleteProfileBloc()..add(CompleteProfileInitEvent()),
      child: BlocConsumer<CompleteProfileBloc, CompleteProfileState>(
        builder: (context, state) {
          if (state is CompleteProfileInitial) {
            return const CompleteProfile();
          }

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}