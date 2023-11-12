import 'package:flutter/material.dart';
import 'package:threads_replica/controller/forgotPasswordController.dart';
import 'package:threads_replica/utils/colors.dart';

import '../controller/signInController.dart';

Widget buildContent(ForgotPasswordController forgotPasswordController) {
  if (forgotPasswordController.statusCode.value == 200) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: const Text(
        "Password was changed successfully",
        style: TextStyle(color: Colors.lightBlue, fontSize: 12),
      ),
    );
  } else {
    if (forgotPasswordController.statusCode.value > 0) {
      return Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          forgotPasswordController.problemType.value,
          style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 12,
              fontWeight: FontWeight.w900),
        ),
      );
    } else {
      return Container();
    }
  }
}

Widget buildLoginResponseHandling(SignInController signInController) {
  if (signInController.statusCode.value == 200) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: const Text(
        "Sign In Successful",
        style: TextStyle(color: blueColor, fontSize: 12),
      ),
    );
  } else if (signInController.statusCode.value == 400) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: const Text(
        "Invalid Username or Password",
        style: TextStyle(color: primaryColor, fontSize: 12),
      ),
    );
  } else if (signInController.statusCode.value != null &&
      signInController.statusCode.value > 0) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Text(
        "Error with statusCode: ${signInController.statusCode.value}",
        style: const TextStyle(
            color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.w900),
      ),
    );
  } else {
    return Container();
  }
}
