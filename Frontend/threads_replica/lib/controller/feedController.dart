import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'token_saver.dart';

class feedController extends GetxController {
  AuthToken userCookie = AuthToken();
  RxInt statusCode = RxInt(0);
  String url = "http://localhost:3000/api/posts/feed";

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
      //Here the response body itself will contain multiple values.
      //We need to fetch them and Input them in an array of objects and display them one at a time.
      //But first, lets "Display" our post.
      //We have getPost.
      //Will it be a FutureBuilder or a GetBuilder?

      if (response.statusCode == 200) {
        print("The Response Body: ${response.body}");
      } else {
        print("The Status Code is: ${response.statusCode}");
      }
    } catch (error) {
      print("Error in the feedController function: ${error}");
    }
  }
}
