import 'package:chat_gpt_demo/screens/register_screen.dart';
import 'package:chat_gpt_demo/utils/color_constants.dart';
import 'package:chat_gpt_demo/utils/string_constants.dart';
import 'package:chat_gpt_demo/utils/text_styles.dart';
import 'package:chat_gpt_demo/widgets/button_widget.dart';
import 'package:chat_gpt_demo/widgets/idea_fields.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                ColorConstants.blue05036d,
                ColorConstants.blue050135
              ])),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/vector.png"),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  StringConstants.welcome,
                  style: TextStyles.textStyleFont32Weight700
                      .copyWith(color: ColorConstants.white),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  StringConstants.ask,
                  style: TextStyles.textStyleFont32Weight700
                      .copyWith(fontSize: 16, color: ColorConstants.white),
                ),
                const SizedBox(
                  height: 40,
                ),
                Image.asset("assets/images/sun.png"),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  StringConstants.examples,
                  style: TextStyles.textStyleFont32Weight700
                      .copyWith(fontSize: 18, color: ColorConstants.white),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Column(
                  children: [
                    IdeaFieldWidget(text: StringConstants.explainQuantum),
                    IdeaFieldWidget(text: StringConstants.birthdayIdeas),
                    IdeaFieldWidget(text: StringConstants.request),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
                ButtonWidget(
                    text: StringConstants.next,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
