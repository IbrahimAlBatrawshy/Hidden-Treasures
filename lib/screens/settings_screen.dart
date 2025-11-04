import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidden_treasures/constants/app_colors.dart';
import '../cubits/auth/auth_cubit.dart';
import '../widgets/settings_tile.dart';
import '../widgets/section_title.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;
  bool darkMode = false;
  bool twoFactorAuth = false;
  String language = 'English';

  Future<void> _resetPassword() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => isLoading = true);
    final authCubit = context.read<AuthCubit>();
    try {
      await authCubit.sendPasswordResetEmail(_emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context); // Close the dialog
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send reset email: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: AppColors.secondary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SectionTitle('Display Settings'),
          const SizedBox(height: 15),
          SettingsTile(
            title: 'Dark Mode',
            subtitle: 'Enable dark theme',
            trailing: Switch(
              value: darkMode,
              onChanged: (value) => setState(() => darkMode = value),
              activeColor: const Color(0xFFFF7643),
            ),
          ),
          const SizedBox(height: 25),
          const SectionTitle('Security Settings'),
          const SizedBox(height: 15),
          SettingsTile(
            title: 'Two-Factor Authentication',
            subtitle: 'Add extra security to your account',
            trailing: Switch(
              value: twoFactorAuth,
              onChanged: (value) => setState(() => twoFactorAuth = value),
              activeColor: const Color(0xFFFF7643),
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                title: const Text('Reset Password',style: TextStyle(color: AppColors.secondary),),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                        'Enter your email to receive a password reset link.'),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel',style: TextStyle(color: AppColors.secondary),),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonPrimary,
                    ),
                    onPressed: isLoading ? null : _resetPassword,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Send Link',style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Update your password',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          const SectionTitle('Preferences'),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Language',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: language,
                  isExpanded: true,
                  onChanged: (value) => setState(() => language = value!),
                  items: ['English', 'Arabic', 'French', 'Spanish']
                      .map(
                        (lang) =>
                            DropdownMenuItem(value: lang, child: Text(lang)),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
