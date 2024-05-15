import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/core/painter/background_painter.dart';
import 'package:leetcode_tracker/features/home/view/dashboard_view.dart';
import 'package:leetcode_tracker/features/problem_list/view/problem_list_home_view.dart';

class HomeView extends StatefulWidget {
  static const route = '/home';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedScreen = 0;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgroundPainter(),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedScreen,
          onTap: (value) {
            setState(() {
              selectedScreen = value;
            });
          },
          backgroundColor: matteBlack,
          selectedItemColor: appYellow,
          unselectedItemColor: accentBlack,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              label: 'Probelem Lists',
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Builder(
          builder: (context) {
            if (selectedScreen == 0) {
              return const HomeDashboardView();
            } else {
              return const ProblemListView();
            }
          },
        ),
      ),
    );
  }
}
