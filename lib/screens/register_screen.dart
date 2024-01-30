import 'package:chat_gpt_demo/screens/chat_screen.dart';
import 'package:chat_gpt_demo/utils/color_constants.dart';
import 'package:chat_gpt_demo/utils/string_constants.dart';
import 'package:chat_gpt_demo/utils/text_styles.dart';
import 'package:chat_gpt_demo/utils/validations.dart';
import 'package:chat_gpt_demo/widgets/button_widget.dart';
import 'package:chat_gpt_demo/widgets/register_buttons.dart';
import 'package:chat_gpt_demo/widgets/textformfield.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  height: 20,
                ),
                const Text(StringConstants.create,
                    style: TextStyles.textStyleFont24Weight600),
                const SizedBox(
                  height: 20,
                ),
                Text(StringConstants.note,
                    textAlign: TextAlign.center,
                    style: TextStyles.textStyleFont16Weight400
                        .copyWith(color: Colors.grey)),
                const SizedBox(
                  height: 30,
                ),
                Form(
                    key: registerKey,
                    child: Column(
                      children: [
                        TextFormFieldWidget(
                            hint: StringConstants.email,
                            controller: emailController,
                            validator: (val) =>
                                Validations.isEmailValid(emailController.text)),
                        const SizedBox(
                          height: 30,
                        ),
                        ButtonWidget(
                            text: StringConstants.continue_,
                            onPressed: () {
                              if (registerKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("User Registered!!!")));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ChatScreen()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Please enter a valid email address.")));
                              }
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          StringConstants.or,
                          style: TextStyles.textStyleFont16Weight400
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Row(
                          children: [
                            Expanded(
                              child: RegisterButtons(
                                text: StringConstants.google,
                                image: "assets/images/google.png",
                              ),
                            ),
                            Expanded(
                              child: RegisterButtons(
                                  text: StringConstants.microsoft,
                                  image: "assets/images/microsoft.png"),
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
