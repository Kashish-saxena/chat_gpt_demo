import 'package:chat_gpt_demo/utils/color_constants.dart';
import 'package:chat_gpt_demo/utils/text_styles.dart';
import 'package:flutter/material.dart';

class RegisterButtons extends StatelessWidget {
  const RegisterButtons({super.key, required this.text, required this.image});
  final String text;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorConstants.blue1e1a47,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image),
          Text(
            text,
            style: TextStyles.textStyleFont16Weight400
                .copyWith(color: ColorConstants.white),
          ),
        ],
      ),
    );
  }
}
