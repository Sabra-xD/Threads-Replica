import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetUserProfile extends GetxController {
  RxInt statusCode = RxInt(0);
  final Rx<Map<String, dynamic>> responseData = Rx<Map<String, dynamic>>({});

  Future<void> getUserProfile(String query) async {
    try {
      String url = "http://10.0.2.2:3000/api/users/profile/${query}";
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        Uri.parse(url), // Parsing query string into URI
        headers: headers,
      );

      // Checking the status code of the response
      statusCode.value = response.statusCode;

      if (response.statusCode == 200) {
        print("We got the userProfileSucessfully");
        //Having the user info saved here.
        final userInfo = json.decode(response.body);
        responseData.value = userInfo;
      }
    } catch (error) {
      print("Error in the getUserProfile Function: $error");
    }
  }
}
