import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'token_saver.dart';

// ignore: camel_case_types
class feedController extends GetxController {
  AuthToken userCookie = AuthToken();
  RxInt statusCode = RxInt(0);
  String url = "http://10.0.2.2:3000/api/posts/feed";
  List<List<dynamic>> combinedData = [];
  List<dynamic> receivedData = [];
  List<dynamic> receivedUserData = [];

  Future<void> getFeed() async {
    combinedData = [];
    receivedData = [];
    receivedUserData = [];
    String authToken = await userCookie.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'cookie': 'jwt=$authToken',
    };

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      statusCode.value = response.statusCode;

      if (response.statusCode == 200) {
        receivedData = json.decode(response.body);

        //Fetching the userInfo from getUserProfile API using PostedBy ID.
        for (var post in receivedData) {
          String getUserProfile =
              "http://10.0.2.2:3000/api/users/profile/${post['postedBy']}";
          final userResponse = await http.get(Uri.parse(getUserProfile));
          final userInfo = json.decode(userResponse.body);
          receivedUserData.add(userInfo);
        }
        int minLength = receivedData.length < receivedUserData.length
            ? receivedData.length
            : receivedUserData.length;
        //Merging the POST Info with the Maker's(user's) info in a 2D array.
        for (int i = 0; i < minLength; i++) {
          List<dynamic> pair = [receivedData[i], receivedUserData[i]];
          combinedData.add(pair);
        }
        print("Combined Data Sized: ${combinedData.length}");
      } else {
        print("The Status Code is: ${response.statusCode}");
      }
    } catch (error) {
      print("Error in the feedController function: $error");
    }
  }
}
