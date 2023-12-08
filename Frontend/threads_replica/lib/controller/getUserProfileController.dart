import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/baseUrl.dart';

class GetUserProfile extends GetxController {
  RxInt statusCode = RxInt(0);
  final Rx<Map<String, dynamic>> responseData = Rx<Map<String, dynamic>>({});

  Future<Map<String, dynamic>?> getUserProfile(String query) async {
    try {
      String url = "${baseURL()}/api/users/profile/${query}";
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
        print("We got the userProfileSuccessfully");
        // Decoding the response body and returning it
        final userInfo = json.decode(response.body);
        responseData.value = userInfo;
        return userInfo;
      }
    } catch (error) {
      print("Error in the getUserProfile Function: $error");
    }
    return null; // Return null if an error occurs or the response is not 200
  }
}
