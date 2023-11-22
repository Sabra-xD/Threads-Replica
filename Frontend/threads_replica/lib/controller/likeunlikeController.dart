import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'token_saver.dart';

class likeunlikeController extends GetxController {
  AuthToken userCookie = AuthToken();
  RxInt numberofLikes = RxInt(0);
  RxInt statusCode = RxInt(0);

  Future<void> likeunlike(String postID) async {
    //We get the Post ID and post to it.
    String url = "http://10.0.2.2:3000/api/posts/like/$postID";

    String authToken = await userCookie.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'cookie': 'jwt=$authToken',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
      );
      statusCode.value = response.statusCode;

      if (response.statusCode == 200 || response.statusCode == 204) {
        final receivedData = json.decode(response.body);
        print("Like or unliked? : ${receivedData['message']}");
      } else {
        print(
            "Error in the like unlike function with statusCode: ${response.statusCode}");
      }
    } catch (error) {
      print("Error in the like unlike function: $error");
    }
  }
}
