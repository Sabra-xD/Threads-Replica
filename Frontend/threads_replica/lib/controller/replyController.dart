import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:threads_replica/controller/token_saver.dart';

class ReplyController extends GetxController {
  String repliedUser = "";
  String userImg = "";
  RxInt statusCode = RxInt(0);
  Map<String, dynamic> userInfo = {};
  Future<void> postReply(String postID, String text) async {
    statusCode.value = 0;
    print("Post ID: ${postID}");
    String url = "http://10.0.2.2:3000/api/posts/reply/${postID}";
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
      print("The Response body: ${response.body}");
      statusCode.value = response.statusCode;
      if (statusCode.value == 200) {
        print("postReply was sucessful");
      } else {
        print("Error in postReply with statusCode of: ${response.statusCode}");
      }
    } catch (error) {
      print("Error in the postReply: ${error}");
    }
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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
