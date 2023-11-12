import 'package:flutter/material.dart';
import 'package:threads_replica/controller/signInController.dart';
import 'package:get/get.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/widgets/text_input_field.dart';

import '../widgets/building_response_widget_auth.dart';

class SignInScreen extends StatelessWidget {
  final SignInController signInController = Get.put(SignInController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              const SizedBox(
                height: 64,
              ),
              Form(
                autovalidateMode: AutovalidateMode.disabled,
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldInput(
                      textEditingController:
                          signInController.usernameController,
                      hintText: "Enter your username",
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter your username";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFieldInput(
                      textEditingController:
                          signInController.passwordController,
                      showObsecure: true,
                      hintText: "Enter your password",
                      textInputType: TextInputType.text,
                      isPass: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter your Passowrd";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
              //Must Return Something
              Obx(() {
                return AnimatedOpacity(
                  opacity: signInController.statusCode.value > 0 ? 1.0 : 0.0,
                  duration:
                      Duration(seconds: 1), // Adjust the duration as needed
                  child: buildLoginResponseHandling(signInController),
                );
              }),

              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    signInController.confirmSignIn();
                  }
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
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
                      "Don't have an account? ",
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
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
