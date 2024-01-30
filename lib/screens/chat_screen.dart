import 'dart:convert';
import 'dart:developer';
import 'package:chat_gpt_demo/models/chat_messages.dart';
import 'package:chat_gpt_demo/screens/gpt4screen.dart';
import 'package:chat_gpt_demo/services/post_api_service.dart';
import 'package:chat_gpt_demo/utils/color_constants.dart';
import 'package:chat_gpt_demo/utils/text_styles.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  List<bool> isSelected = [true, false];
  String version = "gpt-3.5-turbo";
  final List<ChatMessage> messages = [];

  Future<void> sendMessage() async {
    ChatMessage message =
        ChatMessage(text: messageController.text, sender: "user");

    setState(() {
      messages.add(message);
    });
    messageController.clear();
    try {
      final response = await ChatApi.generateText(message.text, version);
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
      log('Error sending message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ColorConstants.blue05036d, ColorConstants.blue050135],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ToggleButtons(
            isSelected: isSelected,
            selectedBorderColor: Colors.white,
            borderRadius: BorderRadius.circular(10),
            borderWidth: 2,
            borderColor: ColorConstants.blue050135,
            onPressed: (newIndex) {
              setState(() {
                if (newIndex == 1) {
                  version = "gpt-4";
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Gpt4Screen()));
                } else {
                  version = "gpt-3.5-turbo";
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
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  ChatMessage message = messages[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
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
                                  ? ColorConstants.purple6750A4
                                  : ColorConstants.blue1e1a47,
                              borderRadius: message.sender == 'user'
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))
                                  : const BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
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
                      fillColor: ColorConstants.blue050135,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: "Type message...",
                      hintStyle: TextStyles.textStyleFont16Weight400
                          .copyWith(color: ColorConstants.white)),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsetsDirectional.all(0),
                        backgroundColor: ColorConstants.purple6750A4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Image.asset("assets/images/send.png"),
                      onPressed: () {
                        if (messageController.text.isNotEmpty) {
                          sendMessage();
                        }
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
