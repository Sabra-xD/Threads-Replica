import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:threads_replica/controller/signInController.dart';
import 'package:get/get.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/widgets/text_input_field.dart';

import '../controller/token_saver.dart';

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
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await signInController.confirmSignIn();
                        if (signInController.statusCode.value == 200) {
                          signInController.dispose();
                          // ignore: use_build_context_synchronously
                          Flushbar(
                            backgroundColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            boxShadows: const [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                            padding: const EdgeInsets.all(15),
                            messageText: const Text(
                              "Login sucessfull. Routing to the Homepage",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.lightBlue),
                            ),
                            duration: const Duration(seconds: 2),
                          ).show(context).then((_) => Get.toNamed("/HomePage"));
                        } else {
                          // ignore: use_build_context_synchronously
                          Flushbar(
                            backgroundColor: Colors.transparent,
                            message: "Issue with the login",
                            padding: const EdgeInsets.all(12),
                            messageText: Text(
                              signInController.statusCode.value == 500
                                  ? "Issue with the login. Please try again later ${signInController.statusCode}"
                                  : "Invalid username or password",
                              style: const TextStyle(
                                  color: Colors.redAccent, fontSize: 16),
                            ),
                            duration: const Duration(seconds: 3),
                          ).show(context);
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
                          onTap: () {
                            Get.toNamed("/SignUpScreen");
                          },
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
