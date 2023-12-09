import 'dart:convert';

import 'package:get/get.dart';
import 'package:threads_replica/utils/baseUrl.dart';

import 'token_saver.dart';
import 'package:http/http.dart' as http;

class FindSuggestUsers extends GetxController {
  RxString message = ''.obs;
  RxInt suggestedStatusCode = 0.obs;
  List<dynamic> receivedData = [];
  Future<void> suggestedUsers() async {
    receivedData = [];
//We need to have the user id and post it..
    String url = "${baseURL()}/api/users/suggested";

    try {
      AuthToken userCookie = AuthToken();
      String authToken = await userCookie.getToken();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'cookie': 'jwt=$authToken',
      };

      final response = await http.get(Uri.parse(url), headers: headers);
      suggestedStatusCode.value = response.statusCode;
      final receivedData = json.decode(response.body);
      print("REceived Data List Length ${receivedData.length}");
    } catch (error) {
      print("Error in he FollowController :${error}");
    }
  }
}
