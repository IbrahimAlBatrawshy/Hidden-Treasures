import 'package:flutter/material.dart';
import 'package:hidden_treasures/screens/help_center_screen.dart';
import 'package:hidden_treasures/screens/logout_screen.dart';
import 'package:hidden_treasures/screens/myaccount_screen.dart';
import 'package:hidden_treasures/screens/notfications_screen.dart';
import 'package:hidden_treasures/screens/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A shared button style for all menu buttons
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFEF5350),
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFEF5350),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/cristiano-ronaldo.jpg',
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.camera_alt, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                ElevatedButton.icon(
                  style: buttonStyle,
                  icon: const Icon(Icons.person, size: 20),
                  label: const Text(
                    'My Account',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyAccountScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton.icon(
                  style: buttonStyle,
                  icon: const Icon(Icons.notifications, size: 20),
                  label: const Text(
                    'Notifications',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotficationsScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton.icon(
                  style: buttonStyle,
                  icon: const Icon(Icons.help, size: 20),
                  label: const Text(
                    'Help Center',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpCenterScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton.icon(
                  style: buttonStyle,
                  icon: const Icon(Icons.settings, size: 20),
                  label: const Text(
                    'Settings',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton.icon(
                  style: buttonStyle,
                  icon: const Icon(Icons.logout, size: 20),
                  label: const Text(
                    'Log Out',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogOutScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
