import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:threads_replica/controller/token_saver.dart';

import 'userInfo.dart';

class SignUpController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final imageController = TextEditingController();
  AuthToken saver = AuthToken();
  String token = "";
  UserInfo _userInfo = UserInfo();

  RxInt statusCode = RxInt(0);

  Future<void> signup() async {
    print("Inside the Sign UP Function");
    print("Old saved Token: ${await saver.getToken()}");
    const String url = "http://10.0.2.2:3000/api/users/signup";

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

        if (response.statusCode == 201) {
          print("Response Data:${response.body}");
          final Map<String, dynamic> receivedData = json.decode(response.body);
          _userInfo.saveUserInfo(receivedData['username'],
              receivedData['email'], receivedData['img'], receivedData['_id']);
          //We should be doing something with that, huh?

          String? setCookieHeader = response.headers['set-cookie'];
          Cookie cookie = Cookie.fromSetCookieValue(setCookieHeader!);
          print("Cookie name: ${cookie.name}");
          print("Cookie received in the Sign UP Function: ${cookie.value}");

          saver.saveToken(cookie.value);

          print("Cookie saved value: ${await saver.getToken()}");
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

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    imageController.dispose();
    bioController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
