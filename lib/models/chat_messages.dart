import 'package:flutter/material.dart';

class ChatMessage {
  const ChatMessage({Key? key, required this.text, required this.sender});
  final String text;
  final String sender;
}
