import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'token_saver.dart';

// ignore: camel_case_types
class feedController extends GetxController {
  AuthToken userCookie = AuthToken();
  int itemCount = 0;
  RxInt statusCode = RxInt(0);
  String _id = '';
  late String postedBy;
  String text = '';
  List likes = [];
  List replies = [];
  String creationTime = '';
  List postPics = [];
  String img = '';
  String username = '';
  String url = "http://10.0.2.2:3000/api/posts/feed";
  List<dynamic> receivedData = [];
  List<String> usernames = [];
  List<String> profilePictures = [];

  Future<void> getFeed() async {
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
        itemCount = receivedData.length;
        print("Received Data: ${receivedData}");
        String getUserUrl = "http://10.0.2.2:3000/api/users/userbyid";
        usernames = [];
        profilePictures = [];
        postPics = [];
        for (var post in receivedData) {
          final Map<String, String> data = {'userID': post['postedBy']};
          final secondresponse = await http.post(Uri.parse(getUserUrl),
              headers: headers, body: json.encode(data));
          final receivedData2 = json.decode(secondresponse.body);
          usernames.add(receivedData2['username']);
          if (receivedData2['profilePic'] != '') {
            profilePictures.add(receivedData2['profilePic']);
          } else {
            profilePictures.add('');
          }
        }

        print("Profile Pcitures :${profilePictures}");
      } else {
        print("The Status Code is: ${response.statusCode}");
      }
    } catch (error) {
      print("Error in the feedController function: ${error}");
    }
  }
}
