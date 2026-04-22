import 'package:flutter/material.dart';
import 'package:flutteraichatbot/chat_message_type.dart';

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final ChatMessageType chatMessageType;

  const ChatMessageWidget({
    super.key,
    required this.text,
    required this.chatMessageType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16.0),
      color: chatMessageType == ChatMessageType.bot
          ? const Color.fromARGB(255, 2, 119, 74)
          : const Color.fromARGB(255, 220, 220, 220),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          chatMessageType == ChatMessageType.bot
              ? Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.smart_toy, color: Colors.white),
                  ),
              )
              : const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.blue),
                ),
        ],
      )
    );
  }
}