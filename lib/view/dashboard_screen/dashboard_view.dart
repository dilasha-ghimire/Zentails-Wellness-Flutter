import 'package:flutter/material.dart';
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
    const HistoryView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: lstBottomScreen[_selectedIndex],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: "History",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
            backgroundColor: const Color.fromARGB(222, 93, 64, 55),
            selectedItemColor: const Color(0xFFFCF5D7),
            unselectedItemColor: const Color.fromARGB(110, 252, 245, 215),
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedLabelStyle: const TextStyle(
                fontSize: 14.0, fontFamily: "Montserrat SemiBold"),
            unselectedLabelStyle: const TextStyle(
                fontSize: 12.0, fontFamily: "Montserrat SemiBold"),
            showSelectedLabels: true,
            showUnselectedLabels: true,
          ),
        ),
      ),
    );
  }
}
