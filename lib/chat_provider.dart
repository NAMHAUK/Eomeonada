import 'package:flutter/foundation.dart';

class ChatMessage {
  final String text;
  final bool isMe;

  ChatMessage({required this.text, required this.isMe});
}

class ChatProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  void sendMessage(String text) {
    _messages.insert(0, ChatMessage(text: text, isMe: true));
    notifyListeners();
  }
}
