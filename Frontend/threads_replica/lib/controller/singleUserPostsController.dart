// ignore: file_names
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/baseUrl.dart';

// ignore: camel_case_types
class findUserPosts extends GetxController {
  List<dynamic> posts = [];
  Future<void> findPosts(String userId) async {
    posts = [];
    try {
      String url = "${baseURL()}/api/users/finduserposts/${userId}";
      final response = await http.get(Uri.parse(url));
      print("We are inside the findPosts");
      if (response.statusCode == 200) {
        final receivedData = json.decode(response.body);

        for (var post in receivedData) {
          posts.add(post);
        }
        print("Posts List: ${posts}");
      }
    } catch (error) {
      print("Error in the findUserPosts: ${error}");
    }
  }
}
