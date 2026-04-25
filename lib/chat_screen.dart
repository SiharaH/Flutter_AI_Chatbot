import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutteraichatbot/chat_message_type.dart';
import 'package:flutteraichatbot/chat_message_widget.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

Future<String> generateResponse(String prompt) async {
  const apiKey =
      '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';
  var url = Uri.https('api.openai.com', '/v1/completions');
  final response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: {
      'model': 'text-davinci-003',
      'prompt': prompt,
      'max_tokens': 4000,
      'temperature': 1,
      'top_p': 1,
      'frequency_penalty': 0.0,
      'presence_penalty': 0.0,
    },
  );
  Map<String, dynamic> newResponse = jsonDecode(response.body);
  return newResponse['choices'][0]['text'];
}

class _ChatScreenState extends State<ChatScreen> {
  final _textcontroller = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Chatbot'),
        backgroundColor: Colors.green[700],
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(31, 14, 49, 7),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  var message = _messages[index];
                  return ChatMessageWidget(
                    text: message.text,
                    chatMessageType: message.chatMessageType,
                  );
                },
              ),
            ),
            Visibility( visible: isLoading, child:Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator(color: Colors.white,))),
            Padding(padding: EdgeInsets.all(8.0), child: Row(
              children: [
                Expanded(
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(color: Colors.white),
                    controller: _textcontroller,
                    decoration: InputDecoration(
                      hintText: 'Type your message here...',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xFF444654),
                    ),
                  ),
                ),
                Visibility(visible: !isLoading,
                child : Container(
                  color: Color(0xFF444654),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () async {
                      setState(() {
                        _messages.add(ChatMessage(
                          text: _textcontroller.text,
                          chatMessageType: ChatMessageType.user,
                        ));
                        isLoading = true;
                      });
                    var input = _textcontroller.text;
                    _textcontroller.clear();
                    Future.delayed(const Duration(milliseconds: 50)).then((_) => _scrollDown());
                    generateResponse(input).then((value) {
                      setState(() {
                        isLoading = false;
                        _messages.add(ChatMessage(
                          text: value,
                          chatMessageType: ChatMessageType.bot,
                        ));
                        
                      });
                      _textcontroller.clear();
                      Future.delayed(const Duration(milliseconds: 50)).then((_) => _scrollDown());
                    });
                    }, 
                  )
                  ,
                ))
              ],
            ),),
            Container(),
          ],
        ),
      ),
    );
  }
}
