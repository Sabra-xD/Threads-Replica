import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:threads_replica/controller/token_saver.dart';

class SignInController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  AuthToken saver = AuthToken();
  String token = "";

  RxInt statusCode = RxInt(0);

  Future<void> confirmSignIn() async {
    print("We are inside the confirmSignIn Function");
    const String url = "http://10.0.2.2:3000/api/users/login";

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
        print("Right before the response");
        final response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: json.encode(data),
        );

        statusCode.value = response.statusCode;
        print("Headers: ${response.headers}");
        if (response.statusCode == 200) {
          final Map<String, dynamic> receivedData = json.decode(response.body);
          String? setCookieHeader = response.headers['set-cookie'];
          print('Set-Cookie header: $setCookieHeader');

          // If you want to parse the cookie, you can use the http package's Cookie.fromSetCookieValue method
          Cookie cookie = Cookie.fromSetCookieValue(setCookieHeader!);
          print(cookie);
          token = receivedData['token'];
          if (cookie != null) {
            print("Cookie NAME: ${cookie.name}");
            print("OMW TO SAVE TOKEN: ${cookie.value}");

            saver.saveToken(cookie.value);
            print("Saved Token: ${await saver.getToken()}");
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
