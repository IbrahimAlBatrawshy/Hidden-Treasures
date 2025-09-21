import 'package:flutter/material.dart';
import 'package:hidden_treasures/constants/app_colors.dart';
import 'package:hidden_treasures/models/user_model.dart';

class ChatRoom extends StatefulWidget {
  final UserModel user;

  const ChatRoom({super.key, required this.user});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final List<Map<String, dynamic>> messages = [
    {"text": "Hello! How can I help you?", "isMe": false},
    {"text": "I need a ride to the airport.", "isMe": true},
    {"text": "Sure, when do you want it?", "isMe": false},
    {"text": "Tomorrow at 9 AM.", "isMe": true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.busy,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(backgroundImage: widget.user.image, radius: 20),
            const SizedBox(width: 10),
            Text(
              widget.user.userName,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.call))],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isMe = messages[index]["isMe"];
                return Align(
                  alignment: isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: isMe
                          ? Colors.deepOrange.shade100
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isMe ? 16 : 0),
                        bottomRight: Radius.circular(isMe ? 0 : 16),
                      ),
                    ),
                    child: Text(
                      messages[index]["text"],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: BottomAppBar(
                color: Colors.grey.shade200,
                elevation: 3,
                shape: const CircularNotchedRectangle(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Type a message....",
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.attach_file,
                        color: Colors.deepOrange,
                      ),
                      prefixIcon: Icon(
                        Icons.emoji_emotions,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
