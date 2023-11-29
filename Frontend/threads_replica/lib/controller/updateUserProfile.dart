import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/userInfo.dart';
import 'package:http/http.dart' as http;

import '../utils/baseUrl.dart';
import 'token_saver.dart';

// ignore: camel_case_types
class updateUserProfileController extends GetxController {
  TextEditingController bioController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newImageController = TextEditingController();

  AuthToken userCookie = AuthToken();
  RxInt statusCode = RxInt(0);
  final UserInfo _userInfo = Get.put(UserInfo());

  Future<void> updateProfile() async {
    String url = "${baseURL()}/api/users/updateUser/${_userInfo.userId.value}";
    String authToken = await userCookie.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'cookie': 'jwt=$authToken',
    };
    final Map<String, String> data = {};
    if (bioController.text.isNotEmpty) {
      data['bio'] = bioController.text;
    }
    if (newPasswordController.text.isNotEmpty) {
      data['password'] = newPasswordController.text;
    }
    if (newImageController.text.isNotEmpty) {
      data['img'] = newImageController.text;
    }
    //Basically we need to post these.
    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(data));

      print("Status Code: ${response.statusCode}");
      statusCode.value = response.statusCode;
      if (response.statusCode == 200) {
        // final Map<String, dynamic> receivedData = json.decode(response.body);
      }
    } catch (error) {
      print("Error in the updateUserProfile : ${error}");
    }
  }

  @override
  void onClose() {
    bioController.dispose();
    newImageController.dispose();
  }
}
