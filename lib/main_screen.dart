import 'package:flutter/material.dart';
import 'home_page.dart';
import 'calculator_screen.dart';
import 'profile_page.dart';
import 'social_media_page.dart';

// The main screen with a bottom navigation bar that switches between four pages.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

// State for MainScreen. Tracks the selected tab and holds the four pages.
class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  // The four pages of the app. IndexedStack keeps every page alive so each
  // page's state (for example what is typed in the calculator) is preserved
  // while switching tabs.
  final List<Widget> pages = const [
    HomePage(),
    CalculatorScreen(),
    ProfilePage(),
    SocialMediaPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            selectedIcon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.share_outlined),
            selectedIcon: Icon(Icons.share),
            label: 'Social Media',
          ),
        ],
      ),
    );
  }
}
