import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/forgotPasswordController.dart';
import 'package:threads_replica/widgets/text_input_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final forgottPasswordController forgotPasswordController =
        Get.put(forgottPasswordController());
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
                        textEditingController:
                            forgotPasswordController.usernameController,
                        hintText: "Enter your username",
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFieldInput(
                        textEditingController:
                            forgotPasswordController.oldPassowrdController,
                        hintText: "Enter your old password",
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFieldInput(
                        textEditingController:
                            forgotPasswordController.newPasswordController,
                        hintText: "Enter your new password",
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                )),
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  //Call the function here.
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
