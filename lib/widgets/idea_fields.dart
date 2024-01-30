import 'package:chat_gpt_demo/utils/color_constants.dart';
import 'package:chat_gpt_demo/utils/text_styles.dart';
import 'package:flutter/material.dart';

class IdeaFieldWidget extends StatelessWidget {
  const IdeaFieldWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      decoration: BoxDecoration(
          color: ColorConstants.blue1e1a47,
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyles.textStyleFont16Weight400
            .copyWith(fontSize: 16, color: ColorConstants.white),
      ),
    );
  }
}
