import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final imageController = TextEditingController();
  RxInt statusCode = RxInt(0);

  Future<void> signup() async {
    print("Inside the Sign UP Function");
    const String url = "http://localhost:3000/api/users/signup";

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> data = {
      'username': usernameController.text,
      'email': emailController.text,
      'name': nameController.text,
      'password': passwordController.text,
      'bio': bioController.text,
    };

    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        nameController.text.isNotEmpty) {
      try {
        final response = await http.post(Uri.parse(url),
            headers: headers, body: json.encode(data));

        statusCode.value = response.statusCode;

        if (response.statusCode == 200) {
          print("Response Data:${response.body}");
        } else {
          print("Error: ${response.body}");
        }
      } catch (error) {
        print(error);
      }
    } else {
      print("Post was failed due to insuficient input.");
    }
  }
}
