import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:threads_replica/controller/token_saver.dart';

import '../utils/baseUrl.dart';

class PostController extends GetxController {
  RxInt deleteStatusCode = RxInt(0);
  Future<void> deletePost(String postID) async {
    String url = "${baseURL()}/api/posts/delete/$postID";
    AuthToken userCookie = AuthToken();
    String authToken = await userCookie.getToken();
    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'cookie': 'jwt=$authToken',
      };

      final response = await http.delete(Uri.parse(url), headers: headers);
      deleteStatusCode.value = response.statusCode;
      if (response.statusCode == 200) {
        print("Post was deleted Sucessfully");
      } else {
        print("UnAuthoried");
      }
    } catch (error) {
      print("Error in the deletePost ${error}");
    }
  }
}
