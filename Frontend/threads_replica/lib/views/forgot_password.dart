import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/forgotPasswordController.dart';
import 'package:threads_replica/widgets/text_input_field.dart';

import '../widgets/building_response_widget_auth.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController forgotPasswordController =
        Get.put(ForgotPasswordController());
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldInput(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your username";
                          }
                          return null;
                        },
                        textEditingController:
                            forgotPasswordController.usernameController,
                        hintText: "Enter your username",
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFieldInput(
                        validator: (value) {
                          if (value!.isEmpty) return "Please enter your email";
                          return null;
                        },
                        textEditingController:
                            forgotPasswordController.emailController,
                        hintText: "Enter your email",
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFieldInput(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your old password";
                          }
                          return null;
                        },
                        textEditingController:
                            forgotPasswordController.oldPasswordController,
                        hintText: "Enter your old password",
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFieldInput(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your new password";
                          }
                          return null;
                        },
                        textEditingController:
                            forgotPasswordController.newPasswordController,
                        hintText: "Enter your new password",
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                )),
            Obx(() {
              return AnimatedOpacity(
                opacity:
                    forgotPasswordController.statusCode.value > 0 ? 1.0 : 0.0,
                duration:
                    const Duration(seconds: 1), // Adjust the duration as needed
                child: buildContent(forgotPasswordController),
              );
            }),
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  forgotPasswordController.forgotPassword();
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
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
