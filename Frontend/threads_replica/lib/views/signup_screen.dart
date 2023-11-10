import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/signUpController.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/widgets/text_input_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.put(SignUpController());
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    //Username
                    TextFieldInput(
                        textEditingController:
                            signUpController.usernameController,
                        hintText: "Enter your username",
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your username";
                          }
                        }),
                    const SizedBox(
                      height: 24,
                    ),
                    //Email
                    TextFieldInput(
                        textEditingController: signUpController.emailController,
                        hintText: "Enter your Email",
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your Email";
                          }
                        }),
                    const SizedBox(
                      height: 24,
                    ),
                    //name
                    TextFieldInput(
                        textEditingController: signUpController.nameController,
                        hintText: "Enter your name",
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your name";
                          }
                        }),
                    const SizedBox(
                      height: 24,
                    ),
                    //Password
                    TextFieldInput(
                        textEditingController:
                            signUpController.passwordController,
                        hintText: "Enter your Password",
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your username";
                          }
                        }),
                    const SizedBox(
                      height: 24,
                    ),
                    //Bio
                    TextFieldInput(
                      textEditingController: signUpController.bioController,
                      hintText: "Enter your Bio",
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    //Image
                    TextFieldInput(
                      textEditingController: signUpController.imageController,
                      hintText: "Enter your image",
                      textInputType: TextInputType.text,
                    ),
                  ],
                )),
            const SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () {
                print("Inside the on Tap");
                if (_formKey.currentState!.validate()) {
                  print("Pressing on the Sign UP Button");
                  signUpController.signup();
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
                child: const Text("Sign Up"),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already got an account? ",
                  style: TextStyle(color: primaryColor),
                ),
                Text("Sign In",
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold))
              ],
            )
          ],
        ),
      )),
    );
  }
}
