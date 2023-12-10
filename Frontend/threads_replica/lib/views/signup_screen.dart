import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/signUpController.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/widgets/text_input_field.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        //Username
                        TextFieldInput(
                            labelText: "Username",
                            textEditingController:
                                signUpController.usernameController,
                            hintText: "Enter your username",
                            textInputType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your username";
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 24,
                        ),
                        //Email
                        TextFieldInput(
                            labelText: "Email",
                            textEditingController:
                                signUpController.emailController,
                            hintText: "Enter your Email",
                            textInputType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your Email";
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 24,
                        ),
                        //name
                        TextFieldInput(
                            labelText: "Name",
                            textEditingController:
                                signUpController.nameController,
                            hintText: "Enter your name",
                            textInputType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 24,
                        ),
                        //Password
                        TextFieldInput(
                            labelText: "Password",
                            textEditingController:
                                signUpController.passwordController,
                            hintText: "Enter your Password",
                            textInputType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your username";
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 24,
                        ),
                        //Bio
                        TextFieldInput(
                          labelText: "Bio (Optional)",
                          textEditingController: signUpController.bioController,
                          hintText: "Enter your Bio",
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        //Image
                        TextFieldInput(
                          labelText: "Image link (Optinal)",
                          textEditingController:
                              signUpController.imageController,
                          hintText: "Enter your image",
                          textInputType: TextInputType.text,
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 12,
                ),
                Obx(() {
                  if (signUpController.statusCode.value == 201) {
                    return const Text("Sign up sucessful",
                        style: TextStyle(color: primaryColor, fontSize: 12));
                  }
                  if (signUpController.statusCode.value == 409) {
                    return const Text("Username or email are already in use",
                        style: TextStyle(color: primaryColor, fontSize: 12));
                  }
                  if (signUpController.statusCode.value == 400) {
                    return const Text("Invalid input Data",
                        style: TextStyle(color: primaryColor, fontSize: 12));
                  }
                  if (signUpController.statusCode.value > 0) {
                    return Text(
                        "Error in SignUp with statusCode of: ${signUpController.statusCode.value}",
                        style:
                            const TextStyle(color: primaryColor, fontSize: 12));
                  }
                  return Container();
                }),
                InkWell(
                  onTap: () async {
                    FocusScope.of(context).unfocus();

                    if (formKey.currentState!.validate()) {
                      await signUpController.signup();
                      if (signUpController.statusCode.value == 201) {
                        signUpController.dispose();
                        Get.offAllNamed("/HomePage");
                      }
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
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already got an account? ",
                      style: TextStyle(color: primaryColor),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.offAllNamed("/SignInScreen");
                        },
                        child: const Text("Sign In",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold))),
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
