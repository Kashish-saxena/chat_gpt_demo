import 'package:flutter/material.dart';
import '../utils/color_constants.dart';
import '../utils/text_styles.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const ButtonWidget({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.purple4F378B,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4))),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyles.textStyleFont24Weight600
                .copyWith(fontSize: 18, color: ColorConstants.white),
          )),
    );
  }
}
