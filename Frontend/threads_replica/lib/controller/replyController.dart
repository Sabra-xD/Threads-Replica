// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:threads_replica/controller/token_saver.dart';

import '../utils/baseUrl.dart';

class ReplyController extends GetxController {
  String repliedUser = "";
  String userImg = "";
  RxInt statusCode = RxInt(0);
  Map<String, dynamic> userInfo = {};
  Future<void> postReply(String postID, String text) async {
    statusCode.value = 0;
    print("Post ID: $postID");
    String url = "${baseURL()}/api/posts/reply/$postID";
    try {
      AuthToken userCookie = AuthToken();
      String authToken = await userCookie.getToken();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'cookie': 'jwt=$authToken',
      };

      final Map<String, String> data = {
        'text': text,
      };
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(data),
      );
      statusCode.value = response.statusCode;
      if (statusCode.value == 200) {
      } else {
        print("Error in postReply with statusCode of: ${response.statusCode}");
      }
    } catch (error) {
      print("Error in the postReply: $error");
    }
  }

  Future<void> deleteReply(postID, replyID) async {
    //We need user id from token.
    //     const userId = req.user._id;
    // const postId = req.params.id;
    // const replyId = req.params.replyId;
    String url = "${baseURL()}/api/posts/reply/$postID/$replyID";

    try {
      AuthToken userCookie = AuthToken();
      String authToken = await userCookie.getToken();
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'cookie': 'jwt=$authToken',
      };
      final response = await http.delete(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        print("Delete was made sucessfully");
      } else {
        print(
            "Something went wrong with StatusCode of: ${response.statusCode}");
      }
    } catch (error) {
      print("Error in the deleteReply: $error");
    }
  }

  Future<void> getUser(String userID) async {
    repliedUser = "";
    String getUserProfile = "${baseURL()}/api/users/profile/$userID";
    final userResponse = await http.get(Uri.parse(getUserProfile));
    if (userResponse.statusCode == 200) {
      userInfo = json.decode(userResponse.body);
      repliedUser = userInfo['username'];
      userImg = userInfo['profilePic'];
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
