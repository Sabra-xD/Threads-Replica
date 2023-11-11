import 'package:flutter/material.dart';
import 'package:threads_replica/controller/signInController.dart';
import 'package:get/get.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/widgets/text_input_field.dart';

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
                if (signInController.statusCode.value == 200) {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    child: const Text(
                      "Sign In Sucessful",
                      style: TextStyle(color: primaryColor, fontSize: 12),
                    ),
                  );
                } else {
                  if (signInController.statusCode.value == 400) {
                    return Container(
                      padding: const EdgeInsets.all(15),
                      child: const Text(
                        "Invalid Username or Password",
                        style: TextStyle(color: primaryColor, fontSize: 12),
                      ),
                    );
                  } else {
                    if (signInController.statusCode.value > 0) {
                      return Container(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          "Error with statusCode: ${signInController.statusCode.value}",
                          style: const TextStyle(
                              color: primaryColor, fontSize: 12),
                        ),
                      );
                    }
                    return Container();
                  }
                }
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
