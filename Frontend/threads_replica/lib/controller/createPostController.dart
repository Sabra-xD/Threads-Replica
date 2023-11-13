import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:threads_replica/controller/token_saver.dart';

class createPostController extends GetxController {
  final threadText = TextEditingController();
  final threadImage = TextEditingController();
  AuthToken userToken = AuthToken();
  RxInt statusCode = RxInt(0);

  Future<void> createPost() async {
    String url = "http://localhost:3000/api/posts/create";

    print("Printing from inside create Post: ${await userToken.getToken()}");

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> data = {
      'postedBy': "655169c480275623b6eb4eff",
      'text': threadText.text,
    };

    try {
      print("Printing from inside create Post: ${await userToken.getToken()}");
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
