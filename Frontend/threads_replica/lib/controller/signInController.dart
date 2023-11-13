import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
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
        final response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: json.encode(data),
        );

        statusCode.value = response.statusCode;

        if (response.statusCode == 200) {
          final Map<String, dynamic> receivedData = json.decode(response.body);
          token = receivedData['token'];
          if (token != "") {
            print("OMW TO SAVE TOKEN: ${token}");
            //We should save it in our SharedPrefs
            saver.saveToken(token);
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
