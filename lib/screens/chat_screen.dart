import 'dart:convert';

import 'package:chat_gpt_demo/models/chat_messages.dart';
import 'package:chat_gpt_demo/services/post_api_service.dart';
import 'package:chat_gpt_demo/utils/color_constants.dart';
import 'package:chat_gpt_demo/utils/string_constants.dart';
import 'package:chat_gpt_demo/utils/text_styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  List<bool> isSelected = [true, false];
  String version = "ChatGpt - 3.5";
  final List<ChatMessage> messages = [];

  Future<void> sendMessage() async {
    ChatMessage message =
        ChatMessage(text: messageController.text, sender: "user");

    setState(() {
      messages.add(message);
    });
    messageController.clear();

    try {
      final response = await ChatApi.generateText(message.text);
      final jsonResponse = json.decode(response);

      if (jsonResponse.containsKey('choices')) {
        final choices = jsonResponse['choices'];
        if (choices.isNotEmpty && choices[0].containsKey('message')) {
          final messageContent = choices[0]['message'];
          if (messageContent.containsKey('content')) {
            final content = messageContent['content'];
            setState(() {
              messages.add(ChatMessage(text: content, sender: "bot"));
            });
          }
        }
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blue38419D,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: ColorConstants.blue200E3A,
        centerTitle: true,
        title: Text(
          version,
          style: TextStyles.textStyleFont20Weight600,
        ),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        ToggleButtons(
          isSelected: isSelected,
          selectedBorderColor: Colors.white,
          borderRadius: BorderRadius.circular(10),
          borderWidth: 2,
          borderColor: ColorConstants.blue200E3A,
          onPressed: (newIndex) {
            setState(() {
              if (newIndex == 1) {
                version = "ChatGpt - 4.0";
              } else {
                version = "ChatGpt - 3.5";
              }
              for (int index = 0; index < isSelected.length; index++) {
                if (index == newIndex) {
                  isSelected[index] = true;
                } else {
                  isSelected[index] = false;
                }
              }
            });
          },
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('GPT - 3.5',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('GPT - 4.0',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
              // reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                ChatMessage message = messages[index];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: message.sender == 'user'
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: message.sender == 'user'
                                ? ColorConstants.blue3887BE
                                : ColorConstants.blue52D3D8,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            message.text,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Stack(
            children: [
              TextField(
                onEditingComplete: () => sendMessage(),
                controller: messageController,
                style: const TextStyle(color: ColorConstants.white),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorConstants.blue200E3A,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: StringConstants.message,
                    hintStyle: TextStyles.textStyleFont14Weight400),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: ColorConstants.white,
                    ),
                    onPressed: () => sendMessage()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
