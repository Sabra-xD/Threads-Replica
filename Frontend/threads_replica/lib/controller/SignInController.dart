import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:threads_replica/controller/token_saver.dart';
import 'package:threads_replica/controller/userInfo.dart';

import '../utils/baseUrl.dart';

class SignInController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final UserInfo _userInfo = UserInfo();
  AuthToken saver = AuthToken();
  String token = "";

  RxInt statusCode = RxInt(0);

  Future<void> confirmSignIn() async {
    String url = "${baseURL()}/api/users/login";

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
        final response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: json.encode(data),
        );

        statusCode.value = response.statusCode;
        if (response.statusCode == 200) {
          final Map<String, dynamic> receivedData = json.decode(response.body);
          print("User profile picutre link: ${receivedData['profilePic']}");
          print("User followrs: ${receivedData['followers']}");
          _userInfo.saveUserInfo(
              receivedData['username'],
              receivedData['email'],
              receivedData['profilePic'],
              receivedData['_id'],
              receivedData['followers'],
              receivedData['following']);
          String? setCookieHeader = response.headers['set-cookie'];
          Cookie cookie = Cookie.fromSetCookieValue(setCookieHeader!);
          if (cookie.name == "jwt") {
            saver.saveToken(cookie.value);
          }
        }
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
