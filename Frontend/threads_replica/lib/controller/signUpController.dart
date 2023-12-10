// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:threads_replica/controller/token_saver.dart';

import '../utils/baseUrl.dart';
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
    String url = "${baseURL()}/api/users/signup";

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> data = {
      'username': usernameController.text,
      'email': emailController.text,
      'name': nameController.text,
      'password': passwordController.text,
    };
    if (bioController.text.isNotEmpty) {
      data['bio'] = bioController.text;
    }

    try {
      print("We are inside the try");
      if (usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          nameController.text.isNotEmpty) {
        print("Posting...");
        final response = await http.post(Uri.parse(url),
            headers: headers, body: json.encode(data));

        statusCode.value = response.statusCode;

        print("Posted the statusCode is ${response.statusCode}");

        if (response.statusCode == 201) {
          print("Response Data:${response.body}");
          final Map<String, dynamic> receivedData = json.decode(response.body);
          _userInfo.saveUserInfo(
              receivedData['username'],
              receivedData['email'],
              receivedData['img'],
              receivedData['_id'], [], []);
          String? setCookieHeader = response.headers['set-cookie'];
          Cookie cookie = Cookie.fromSetCookieValue(setCookieHeader!);
          if (cookie.name == "jwt") {
            print("Should've saved the cookie now");
            saver.saveToken(cookie.value);
          }

          print("Should've fetched the data");
          print("Cookie saved value: ${await saver.getToken()}");
        }
      } else {
        print("Error: Insufficient Input");
      }
    } catch (error) {
      print(error);
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
