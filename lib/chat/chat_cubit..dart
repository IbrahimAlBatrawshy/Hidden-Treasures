// lib/cubits/chatbot/chatbot_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidden_treasures/chat/chat_service.dart';


// States
abstract class ChatbotState {}

class ChatbotInitial extends ChatbotState {}

class ChatbotLoading extends ChatbotState {
  final List<ChatMessage> messages;
  ChatbotLoading(this.messages);
}

class ChatbotLoaded extends ChatbotState {
  final List<ChatMessage> messages;
  ChatbotLoaded(this.messages);
}

class ChatbotError extends ChatbotState {
  final String error;
  final List<ChatMessage> messages;
  ChatbotError(this.error, this.messages);
}

// Cubit
class ChatbotCubit extends Cubit<ChatbotState> {
  final ChatbotService _chatbotService = ChatbotService();
  final List<ChatMessage> _conversationHistory = [];

  ChatbotCubit() : super(ChatbotInitial()) {
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    _conversationHistory.add(
      ChatMessage(
        role: 'assistant',
        content: '👋 Hello! I\'m your personal tourist guide. I can help you with:\n\n'
            '🗺️ Places to visit\n'
            '🚇 Transportation routes\n'
            '🍽️ Food recommendations\n'
            '🛡️ Safety advice\n'
            '💰 Currency & tipping\n'
            '🌍 Local culture\n\n'
            'What would you like to know?',
      ),
    );
    emit(ChatbotLoaded(List.from(_conversationHistory)));
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // Add user message
    final userMessage = ChatMessage(role: 'user', content: message);
    _conversationHistory.add(userMessage);
    emit(ChatbotLoading(List.from(_conversationHistory)));

    try {
      // Get AI response
      final response = await _chatbotService.sendMessage(
        message,
        _conversationHistory.where((msg) => msg.role != 'assistant' || msg != _conversationHistory.first).toList(),
      );

      // Add assistant response
      final assistantMessage = ChatMessage(role: 'assistant', content: response);
      _conversationHistory.add(assistantMessage);
      emit(ChatbotLoaded(List.from(_conversationHistory)));
    } catch (e) {
      emit(ChatbotError(e.toString(), List.from(_conversationHistory)));
      // Restore to loaded state after error
      await Future.delayed(const Duration(seconds: 2));
      emit(ChatbotLoaded(List.from(_conversationHistory)));
    }
  }

  void clearChat() {
    _conversationHistory.clear();
    _addWelcomeMessage();
  }

  List<ChatMessage> get messages => _conversationHistory;
}