import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:threads_replica/controller/userInfo.dart';

class ReplyController extends GetxController {
  String repliedUser = "";
  String userImg = "";
  Map<String, dynamic> userInfo = {};
  Future<void> postReply(String PostID) async {
    String url = "http://10.0.2.2:3000/api/posts/reply/${PostID}";
  }

  Future<void> getUser(String userID) async {
    repliedUser = "";
    String getUserProfile = "http://10.0.2.2:3000/api/users/profile/${userID}";
    final userResponse = await http.get(Uri.parse(getUserProfile));
    if (userResponse.statusCode == 200) {
      userInfo = json.decode(userResponse.body);
      repliedUser = userInfo['username'];
      userImg = userInfo['profilePic'];
    }
  }
}
