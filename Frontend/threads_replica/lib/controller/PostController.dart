import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:threads_replica/controller/token_saver.dart';

import '../utils/baseUrl.dart';

class PostController extends GetxController {
  RxInt deleteStatusCode = RxInt(0);
  final threadText = TextEditingController();
  final threadImage = TextEditingController();
  AuthToken userCookie = AuthToken();
  RxInt createPoststatusCode = RxInt(0);

  Future<void> createPost(String? pictureLink) async {
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

    if (pictureLink != null) {
      data['img'] = pictureLink;
    }

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

        createPoststatusCode.value = response.statusCode;
        if (response.statusCode == 200) {}
      }
      // ignore: empty_catches
    } catch (error) {}
  }

  Future<void> deletePost(String postID) async {
    String url = "${baseURL()}/api/posts/delete/$postID";
    AuthToken userCookie = AuthToken();
    String authToken = await userCookie.getToken();
    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'cookie': 'jwt=$authToken',
      };

      final response = await http.delete(Uri.parse(url), headers: headers);
      deleteStatusCode.value = response.statusCode;
      if (response.statusCode == 200) {
        print("Post was deleted Sucessfully");
      } else {
        print("UnAuthoried");
      }
    } catch (error) {
      print("Error in the deletePost ${error}");
    }
  }
}
