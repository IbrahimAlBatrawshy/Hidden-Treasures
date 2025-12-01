import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidden_treasures/chat/chat_cubit..dart';
import 'package:hidden_treasures/chat/chat_service.dart';
import 'package:hidden_treasures/constants/app_colors.dart';
import 'package:intl/intl.dart';

class TouristChatbotScreen extends StatefulWidget {
  const TouristChatbotScreen({super.key});

  @override
  State<TouristChatbotScreen> createState() => _TouristChatbotScreenState();
}

class _TouristChatbotScreenState extends State<TouristChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(BuildContext context) {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      context.read<ChatbotCubit>().sendMessage(message);
      _messageController.clear();
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.smart_toy, color: Colors.white),
            SizedBox(width: 8),
            Center(
              child: Text(
                'Tourist Guide AI',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.buttonPrimary,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              context.read<ChatbotCubit>().clearChat();
              _scrollToBottom();
            },
            tooltip: 'Clear Chat',
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick suggestion chips
          _buildQuickSuggestions(context),

          // Chat messages
          Expanded(
            child: BlocConsumer<ChatbotCubit, ChatbotState>(
              listener: (context, state) {
                if (state is ChatbotLoaded || state is ChatbotLoading) {
                  _scrollToBottom();
                }
                if (state is ChatbotError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${state.error}'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              builder: (context, state) {
                List<ChatMessage> messages = [];
                bool isLoading = false;

                if (state is ChatbotLoaded) {
                  messages = state.messages;
                } else if (state is ChatbotLoading) {
                  messages = state.messages;
                  isLoading = true;
                } else if (state is ChatbotError) {
                  messages = state.messages;
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (isLoading && index == messages.length) {
                      return _buildTypingIndicator();
                    }
                    final message = messages[index];
                    return _buildMessageBubble(message);
                  },
                );
              },
            ),
          ),

          // Input area
          _buildInputArea(context),
        ],
      ),
    );
  }

  Widget _buildQuickSuggestions(BuildContext context) {
    final suggestions = [
      {'icon': '🗺️', 'text': 'Places to visit'},
      {'icon': '🚇', 'text': 'Transportation'},
      {'icon': '🍽️', 'text': 'Food spots'},
      {'icon': '💰', 'text': 'Tipping guide'},
    ];

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ActionChip(
              avatar: Text(
                suggestion['icon']!,
                style: const TextStyle(fontSize: 18),
              ),
              label: Text(suggestion['text']!),
              onPressed: () {
                _messageController.text = suggestion['text']!;
                _sendMessage(context);
              },
              backgroundColor: Colors.white,
              elevation: 2,
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isUser = message.role == 'user';
    final timeFormat = DateFormat('HH:mm');

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? AppColors.buttonPrimary : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUser)
              Row(
                children: [
                  Icon(Icons.smart_toy, size: 16, color: Colors.teal[700]),
                  const SizedBox(width: 4),
                  Text(
                    'Tourist Guide',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[700],
                    ),
                  ),
                ],
              ),
            if (!isUser) const SizedBox(height: 4),
            Text(
              message.content,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black87,
                fontSize: 15,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              timeFormat.format(message.timestamp),
              style: TextStyle(
                color: isUser ? Colors.white70 : Colors.grey[600],
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(3, (index) {
                  return TweenAnimationBuilder(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: (value + index * 0.3) % 1.0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.buttonPrimary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Ask me anything about tourism...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: (_) => _sendMessage(context),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: AppColors.buttonPrimary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.buttonPrimary,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () => _sendMessage(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
