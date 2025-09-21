import 'package:flutter/material.dart';
import 'package:hidden_treasures/constants/app_colors.dart';
import 'package:hidden_treasures/models/user_model.dart';
import 'package:hidden_treasures/screens/bottomNavPages/chats/chat_details.dart';
// import 'package:hidden_treasures/screens/chat_room.dart'; // <-- make sure ChatRoom is imported

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late List<UserModel> user = UserModel.users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.busy,
        foregroundColor: Colors.white,
        title: const Text(
          "Chats",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: user[index].image,
                    radius: 30,
                  ),
                  title: Text(user[index].userName),
                  subtitle: const Text("Tap to chat"),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatRoom(
                            user: user[index], // pass the selected user
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.chat),
                    iconSize: 20,
                    color: Colors.deepOrange,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
