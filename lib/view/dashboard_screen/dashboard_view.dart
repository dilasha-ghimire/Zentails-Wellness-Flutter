import 'package:flutter/material.dart';
import 'package:zentails_wellness/view/user_screen/explore_view.dart';
import 'package:zentails_wellness/view/user_screen/history_view.dart';
import 'package:zentails_wellness/view/user_screen/home_view.dart';
import 'package:zentails_wellness/view/user_screen/profile_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;

  final List<Widget> lstBottomScreen = [
    const HomeView(),
    const ExploreView(),
    const HistoryView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    double bottomNavHeight = MediaQuery.of(context).size.height * 0.07;

    return Scaffold(
      body: SafeArea(
        top: true,
        child: lstBottomScreen[_selectedIndex],
      ),
      bottomNavigationBar: SizedBox(
        height: bottomNavHeight,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: "History"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
          backgroundColor: const Color(0xFF5D4037),
          selectedItemColor: const Color(0xFFFCF5D7),
          unselectedItemColor: const Color.fromARGB(110, 252, 245, 215),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
