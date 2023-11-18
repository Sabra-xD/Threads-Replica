import 'package:flutter/material.dart';
import 'package:threads_replica/controller/signInController.dart';
import 'package:get/get.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/widgets/text_input_field.dart';

import '../controller/token_saver.dart';
import '../widgets/building_response_widget_auth.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  final SignInController signInController = Get.put(SignInController());
  AuthToken cookie = AuthToken();

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: mobileBackgroundColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.disabled,
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.all(12),
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
                              return null;
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
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Must Return Something
                  Obx(() {
                    return AnimatedOpacity(
                      opacity:
                          signInController.statusCode.value > 0 ? 1.0 : 0.0,
                      duration: const Duration(
                          seconds: 1), // Adjust the duration as needed
                      child: buildLoginResponseHandling(signInController),
                    );
                  }),

                  InkWell(
                    onTap: () async {
                      // Focus.of(context)
                      //     .unfocus(); //Remove keyboard when button is pressed
                      if (_formKey.currentState!.validate()) {
                        signInController.confirmSignIn();
                        if (signInController.statusCode.value == 200) {
                          // Rotue * Clean
                          print(
                              "Printing from inside the Login button: ${await cookie.getToken()}");
                          signInController.dispose();
                        }
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(12),
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
                        child: InkWell(
                          onTap: () {},
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
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
        ),
      ),
    );
  }
}
