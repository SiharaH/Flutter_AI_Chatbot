import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

// Future<String> generateResponse(String prompt) async {
//   const apiKey = '';
//   var url = Uri.https('api.openai.com', '/v1/completions');
//   final response = await http.post();
//   return response.body;

// }

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
