import 'dart:convert';

import 'package:get/get.dart';

import 'token_saver.dart';
import 'package:http/http.dart' as http;

class FolloweController extends GetxController {
  RxString message = ''.obs;
  RxInt statusCode = 0.obs;
  Future<void> FollowOrUnFollow(String userId) async {
//We need to have the user id and post it..
    String url = "http://10.0.2.2:3000/api/users/follow/$userId";

    try {
      AuthToken userCookie = AuthToken();
      String authToken = await userCookie.getToken();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'cookie': 'jwt=$authToken',
      };

      final response = await http.post(Uri.parse(url), headers: headers);
      statusCode.value = response.statusCode;
      final receivedData = json.decode(response.body);

      message.value = receivedData['message'];
      print("It was pressed the message is ${message.value}");
    } catch (error) {
      print("Error in he FollowController :${error}");
    }
  }
}
