import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/userInfo.dart';
import 'package:http/http.dart' as http;

import 'token_saver.dart';

// ignore: camel_case_types
class updateUserProfileController extends GetxController {
  TextEditingController bioController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newImageController = TextEditingController();

  //The issue is that we create and instance of the RxString.
  //I assumed that it saves that value...
  //But apperantely it does not.

  //It does not have the value. We must set it. Either when routing to the screen we send the value or we set it in an RxString.

  AuthToken userCookie = AuthToken();
  RxInt statusCode = RxInt(0);
  final UserInfo _userInfo = Get.put(UserInfo());

  Future<void> updateProfile() async {
    String url =
        "http://10.0.2.2:3000/api/users/updateUser/${_userInfo.userId.value}";
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
      print("Bio Controller from inside the func:: ${bioController.text}");
      final response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(data));

      print("Status Code: ${response.statusCode}");
      statusCode.value = response.statusCode;
      if (response.statusCode == 200) {
        print("Response Body: ${response.body}");
        final Map<String, dynamic> receivedData = json.decode(response.body);
      }
    } catch (error) {
      print("Error in the updateUserProfile : ${error}");
    }
  }

  @override
  void onClose() {
    bioController.dispose();
    newImageController.dispose();
    newImageController.dispose();
  }
}
