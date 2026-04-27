import 'package:convertify/feature/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
// Κάνε import τις οθόνες σου εδώ
// import 'converter_home_screen.dart';
// import 'search_screen.dart';
// import 'upgrade_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text("Under Construction", style: TextStyle(color: Colors.white))),
    const Center(child: Text("Under Construction", style: TextStyle(color: Colors.white))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.cyanAccent.withOpacity(0.2),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white70),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: const Color(0xFF1A1A25),
          elevation: 10,
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.swap_horiz, color: Colors.cyanAccent),
              icon: Icon(Icons.swap_horiz_outlined, color: Colors.white54),
              label: 'Converter',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.search, color: Colors.cyanAccent),
              icon: Icon(Icons.search_outlined, color: Colors.white54),
              label: 'Search',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.auto_awesome, color: Colors.amber),
              icon: Icon(Icons.auto_awesome_outlined, color: Colors.white54),
              label: 'Upgrade',
            ),
          ],
        ),
      ),
    );
  }
}