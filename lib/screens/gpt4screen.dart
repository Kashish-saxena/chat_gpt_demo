import 'package:chat_gpt_demo/utils/color_constants.dart';
import 'package:chat_gpt_demo/utils/text_styles.dart';
import 'package:flutter/material.dart';

class Gpt4Screen extends StatelessWidget {
  const Gpt4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorConstants.blue05036d, ColorConstants.blue050135],
          ),
        ),
        child: Center(
            child: Text(
          "Premium Required...",
          style: TextStyles.textStyleFont32Weight700
              .copyWith(color: ColorConstants.white),
        )),
      ),
    );
  }
}
