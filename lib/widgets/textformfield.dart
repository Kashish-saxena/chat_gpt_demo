import 'package:chat_gpt_demo/utils/text_styles.dart';
import 'package:flutter/material.dart';
import '../utils/color_constants.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hint;
  final String? Function(dynamic)? validator;
  final Function(String)? onChange;

  final TextEditingController controller;
  const TextFormFieldWidget({
    super.key,
    required this.hint,
    this.validator,
    required this.controller,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: TextFormField(
        style: TextStyles.textStyleFont16Weight400
            .copyWith(color: ColorConstants.white),
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        onChanged: onChange,
        decoration: InputDecoration(
          fillColor: ColorConstants.blue1e1a47,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(width: 1)),
          hintText: hint,
          hintStyle: TextStyles.textStyleFont16Weight400
              .copyWith(color: ColorConstants.white),
        ),
      ),
    );
  }
}
