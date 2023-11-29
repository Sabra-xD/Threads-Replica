// ignore_for_file: avoid_print, camel_case_types, file_names

import 'dart:convert';

import 'package:get/get.dart';
import 'package:threads_replica/controller/token_saver.dart';
import 'package:http/http.dart' as http;
import 'package:threads_replica/utils/baseUrl.dart';

class searchController extends GetxController {
  RxInt statusCode = RxInt(0);
  List<dynamic> matchingUsers = [];
  Future<void> search(String username) async {
    matchingUsers = [];
    try {
      String url = "${baseURL()}/api/users/finduser";
      AuthToken userCookie = AuthToken();
      String authToken = await userCookie.getToken();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'cookie': 'jwt=$authToken',
      };

      final Map<String, String> data = {'username': username};

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(data),
      );

      statusCode.value = response.statusCode;
      if (response.statusCode == 200) {
        print("Search was sucessful, here is the response body");
        final receivedData = json.decode(response.body);
        print("Received data of the search: $receivedData");
        matchingUsers = receivedData;
      } else {
        print(
            "Error in the searchController function with statusCode: ${response.statusCode}");
      }
    } catch (error) {
      print("Error in the SearchController : $error");
    }
  }
}
