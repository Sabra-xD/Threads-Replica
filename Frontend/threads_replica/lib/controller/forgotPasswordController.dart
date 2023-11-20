import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  RxInt statusCode = RxInt(0);
  RxString problemType = RxString("");
  //We need to save the cookie  and call for it to use it.

  Future<void> forgotPassword() async {
    print("This shit function was called");
    const String url = "http://10.0.2.2:3000/api/users/forgotPassword";
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> data = {
      'username': usernameController.text,
      'email': emailController.text,
      'oldPassword': oldPasswordController.text,
      'newPassword': newPasswordController.text
    };

    try {
      print("Inside the try");
      if (usernameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          oldPasswordController.text.isNotEmpty &&
          newPasswordController.text.isNotEmpty) {
        final response = await http.post(Uri.parse(url),
            headers: headers, body: json.encode(data));
        statusCode.value = response.statusCode;
        if (response.statusCode == 200) {
          print("Status Code was 200 it is a sucess: ${response.statusCode}");
        } else {
          final Map<String, dynamic> receivedData = json.decode(response.body);
          problemType.value = receivedData['message'];
          print(
              "Problem in the ForgotPAssword Function : ${response.statusCode}");
        }
      }
    } catch (error) {
      print("Error in the forgotPasswordFunction: ${error.toString()}");
    }
  }
}
