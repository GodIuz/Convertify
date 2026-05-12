import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = true;
  //final String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(
        title: const Text("SETTINGS", style: TextStyle(letterSpacing: 2)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("APPEARANCE"),
          _buildSettingsCard(
            child: Column(
              children: [
                _buildSwitchTile(
                  title: "Dark Mode",
                  subtitle: "Adjust the visual theme",
                  value: _isDarkMode,
                  icon: Icons.dark_mode,
                  onChanged: (val) => setState(() => _isDarkMode = val),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 24),
          // _buildSectionTitle("PREFERENCES"),
          // _buildSettingsCard(
          //   child: Column(
          //     children: [
          //       _buildNavigationTile(
          //         title: "Language",
          //         subtitle: _selectedLanguage,
          //         icon: Icons.language,
          //         onTap: () {
          //           // Εδώ μπορείς να ανοίξεις ένα BottomSheet για επιλογή γλώσσας
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 24),
          _buildSectionTitle("ABOUT"),
          _buildSettingsCard(
            child: Column(
              children: [
                _buildNavigationTile(
                  title: "Privacy Policy",
                  icon: Icons.privacy_tip_outlined,
                  onTap: () {},
                ),
                const Divider(color: Colors.white10, height: 1),
                _buildNavigationTile(
                  title: "Terms of Service",
                  icon: Icons.description_outlined,
                  onTap: () {},
                ),
                const Divider(color: Colors.white10, height: 1),
                ListTile(
                  leading: const Icon(Icons.info_outline, color: Colors.blueAccent),
                  title: const Text("Version", style: TextStyle(color: Colors.white)),
                  trailing: const Text("1.0.0", style: TextStyle(color: Colors.white54)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.4),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF12121A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: child,
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required IconData icon,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, color: Colors.cyanAccent),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      value: value,
      activeThumbColor: Colors.cyanAccent,
      onChanged: onChanged,
    );
  }

  Widget _buildNavigationTile({
    required String title,
    String? subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.cyanAccent),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12))
          : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.white24),
    );
  }
}