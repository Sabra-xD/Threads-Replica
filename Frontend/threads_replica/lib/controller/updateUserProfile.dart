import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/userInfo.dart';
import 'package:http/http.dart' as http;

import 'token_saver.dart';

// ignore: camel_case_types
class updateUserProfileController extends GetxController {
  //Fetch the token from the user.
  TextEditingController bioController = TextEditingController();
  //Password Controller?
  TextEditingController newPasswordController = TextEditingController();

  TextEditingController newImageController = TextEditingController();

  AuthToken userCookie = AuthToken();
  RxInt statusCode = RxInt(0);
  UserInfo _userInfo = Get.put(UserInfo());

  Future<void> updateProfile() async {
    String url =
        "http://10.0.2.2:3000/api/users/updateUser/${_userInfo.userId.value}";
    print("The URL we Post on to Update: ${url}");
    String authToken = await userCookie.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'cookie': 'jwt=$authToken',
    };
    print("Bio Controller: ${bioController.text}");
    final Map<String, String> data = {
      'bio': bioController.text,
    };

    //Basically we need to post these.
    try {
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
  void ClosingBio() {
    bioController.dispose();
  }
}
