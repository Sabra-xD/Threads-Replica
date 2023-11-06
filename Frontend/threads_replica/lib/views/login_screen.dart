import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:threads_replica/controller/signInController.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/widgets/text_input_field.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _username = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _username.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),

            SvgPicture.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Threads_%28app%29_logo.svg/128px-Threads_%28app%29_logo.svg.png",
              height: 64,
              color: primaryColor,
            ),

            const SizedBox(
              height: 64,
            ),
            //Image
            //Email/UserName enter
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldInput(
                      textEditingController: _username,
                      hintText: "Enter your username",
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFieldInput(
                      textEditingController: _password,
                      hintText: "Enter your password",
                      textInputType: TextInputType.text,
                      isPass: true,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                )),

            GestureDetector(
              onTap: () {
                confirmSignIn(_username, _password);
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                child: const Text("Log in"),
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),

            //Button
          ],
        ),
      )),
    );
  }
}
