import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/auth/bloc/auth_bloc.dart';
import 'package:leetcode_tracker/features/auth/view/auth_view.dart';
import 'package:leetcode_tracker/features/complete_profile/view/complete_profile_view.dart';
import 'package:leetcode_tracker/features/dashboard/bloc/bloc/dashboard_bloc.dart';
import 'package:leetcode_tracker/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:leetcode_tracker/features/home/view/home_view.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/repository/leetcode_repository.dart';
import 'package:leetcode_tracker/features/revist_solutions/view/revisit_solution_view.dart';
import 'package:leetcode_tracker/features/solutions/bloc/bloc/solution_bloc.dart';
import 'package:leetcode_tracker/features/solutions/data/repository/solution_repository.dart';
import 'package:leetcode_tracker/features/solutions/view/solution_add_edit_view.dart';
import 'package:leetcode_tracker/features/solutions/view/solution_view.dart';
import 'package:leetcode_tracker/firebase_options.dart';

void main() async {
  WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupInjection();
  final user = FirebaseAuth.instance.currentUser;
  if (user != null && user.emailVerified == false) {
    await FirebaseAuth.instance.signOut();
  }
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(AuthInitEvent()),
        ),
        BlocProvider(
          create: (context) => DashboardBloc()..add(InitDashBoardEvent()),
        ),
        BlocProvider(
          create: (context) => SolutionBloc(
            dashboardRepository: getIt<DashboardRepository>(),
            firebaseAuth: getIt<FirebaseAuth>(),
            leetcodeRespository: getIt<LeetcodeRespository>(),
            solutionRepository: getIt<SolutionRepository>(),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AuthView.route,
        routes: {
          AuthView.route: (context) => const AuthView(),
          CompleteProfileView.route: (context) => const CompleteProfileView(),
          HomeView.route: (context) => const HomeView(),
          SolutionView.route: (context) => const SolutionView(),
          RevisitSolutionview.route: (context) => const RevisitSolutionview(),
        },
      ),
    );
  }
}

final leetcodeTrackerTheme = ThemeData(
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: appYellow,
        onPrimary: Colors.transparent,
        secondary: matteBlack,
        onSecondary: Colors.transparent,
        error: Colors.red,
        onError: Colors.transparent,
        background: Colors.black,
        onBackground: Colors.transparent,
        surface: Colors.grey,
        onSurface: matteBlack));
