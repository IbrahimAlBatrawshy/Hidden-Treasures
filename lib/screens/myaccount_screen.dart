import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidden_treasures/constants/app_colors.dart';
import 'package:hidden_treasures/cubits/user_profile/user_profile_cubit.dart';
import 'package:hidden_treasures/cubits/user_profile/user_profile_state.dart';
import '../widgets/account_info_card.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        title: const Text(
          'My Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.secondary,
        centerTitle: true,
      ),
      body: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(height: 20),
              AccountInfoCard(label: 'Full Name', value: state.displayName ?? 'N/A'),
              const SizedBox(height: 15),
              AccountInfoCard(label: 'Email', value: state.email ?? 'N/A'),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  _nameController.text = state.displayName ?? '';
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      title: const Text('Edit Profile',style: TextStyle(color: AppColors.secondary),),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(labelText: 'Full Name'),
                          ),
                          const SizedBox(height: 10),
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
                          onPressed: () {
                            context.read<UserProfileCubit>().updateProfile(
                                  displayName: _nameController.text
                            );
                            Navigator.pop(context);
                          },
                          child: const Text('Save',style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  'Edit Your Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
