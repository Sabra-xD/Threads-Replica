// ignore: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:threads_replica/controller/token_saver.dart';
import 'package:threads_replica/utils/baseUrl.dart';

// ignore: camel_case_types
class createPostController extends GetxController {
  final threadText = TextEditingController();
  final threadImage = TextEditingController();
  AuthToken userCookie = AuthToken();
  RxInt statusCode = RxInt(0);

  Future<void> createPost() async {
    String url = "${baseURL()}/api/posts/create";

    String authToken = await userCookie.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'cookie': 'jwt=$authToken',
    };

    final Map<String, String> data = {
      'postedBy': authToken,
      'text': threadText.text,
    };

    try {
      print("Printing from inside create Post: ${await userCookie.getToken()}");
      if (threadText.text.isNotEmpty) {
        //Now we fucking post it.
        final response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: json.encode(data),
        );
        print("Response body: ${response.body}");

        statusCode.value = response.statusCode;
        if (response.statusCode == 200) {}
      }
      // ignore: empty_catches
    } catch (error) {}
  }
}
