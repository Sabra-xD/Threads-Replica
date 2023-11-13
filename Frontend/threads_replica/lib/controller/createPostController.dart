import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:threads_replica/controller/token_saver.dart';

class createPostController extends GetxController {
  final threadText = TextEditingController();
  final threadImage = TextEditingController();
  AuthToken userCookie = AuthToken();
  RxInt statusCode = RxInt(0);

  Future<void> createPost() async {
    String url = "http://10.0.2.2:3000/api/posts/create";

    String authToken = await userCookie.getToken();

    print("Printing from inside create Post: ${authToken}");

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'cookie': 'jwt=$authToken',
    };

    final Map<String, String> data = {
      'postedBy': authToken,
      'text': threadText.text,
    };
    print("Header: ${headers}");
    print(data);

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
        if (response.statusCode == 200) {
          print("Post was sucessful");
        }
      }
    } catch (error) {
      print("Erro in the create post controller ${error.toString()}");
    }
  }
}
