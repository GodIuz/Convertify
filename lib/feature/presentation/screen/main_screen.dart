import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:totalUnit/feature/presentation/screen/home_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialization();
  }

  void _initialization() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    FlutterNativeSplash.remove();

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreenTemplate(),
    const SettingsScreen(),
    const UpgradeProScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingScreen();
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _screens,
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Colors.cyanAccent.withValues(alpha: 0.2),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white70),
        ),
      ),
      child: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        backgroundColor: const Color(0xFF1A1A25),
        elevation: 10,
        height: 70,
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
            selectedIcon: Icon(Icons.settings, color: Colors.cyanAccent),
            icon: Icon(Icons.settings_outlined, color: Colors.white54),
            label: 'Settings',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.auto_awesome, color: Colors.amber),
            icon: Icon(Icons.auto_awesome_outlined, color: Colors.white54),
            label: 'Upgrade',
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash_logo.png', width: 120),
            const SizedBox(height: 25),
            const Text(
              "Total Unit",
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
                fontFamily: 'Orbitron',
              ),
            ),
            const SizedBox(height: 40),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(color: Colors.cyanAccent, strokeWidth: 2),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchScreenTemplate extends StatelessWidget {
  const SearchScreenTemplate({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Search Global Units", style: TextStyle(color: Colors.white38, fontWeight: FontWeight.bold)));
}

class UpgradeProScreen extends StatelessWidget {
  const UpgradeProScreen({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Go Ad-Free & Unlimited", style: TextStyle(color: Colors.white38, fontWeight: FontWeight.bold)));
}
