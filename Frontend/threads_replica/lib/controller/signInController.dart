import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignInController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> confirmSignIn() async {
    print("We are inside the confirmSignIn Function");
    const String url = "http://localhost:3000/api/users/login";

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> data = {
      'username': usernameController.text,
      'password': passwordController.text,
    };

    try {
      if (usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        final response = await http.post(Uri.parse(url),
            headers: headers, body: json.encode(data));

        if (response.statusCode == 200) {
          print("Response Data:${response.body}");
        } else {}
      }
    } catch (error) {
      print("Error in the confirm Sign In Function : ${error.toString()}");
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
