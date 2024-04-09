import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/auth/bloc/auth_bloc.dart';
import 'package:leetcode_tracker/features/auth/view/auth_view.dart';
import 'package:leetcode_tracker/features/dashboard/bloc/bloc/dashboard_bloc.dart';
import 'package:leetcode_tracker/features/dashboard/data/model/leetcode_data_model.dart';
import 'package:leetcode_tracker/features/dashboard/view/dashboard_view.dart';

class HomeView extends StatelessWidget {
  static const route = '/home';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appYellow,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        backgroundColor: matteBlack,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: appYellow,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogoutEvent());
                Navigator.of(context).popAndPushNamed(AuthView.route);
              },
              icon: const Icon(
                Icons.logout,
                color: appYellow,
              ))
        ],
      ),
      body: Column(
        children: [
          BlocConsumer<DashboardBloc, DashboardState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is DashboardDoneState) {
                return DashboardView(
                    name: state.userState.username, userState: state.userState);
              }
              return const DashboardView(
                name: 'John Doe',
                userState: null,
              );
            },
          )
        ],
      ),
    );
  }
}
