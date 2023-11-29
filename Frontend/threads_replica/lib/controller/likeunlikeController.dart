import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/baseUrl.dart';
import 'token_saver.dart';

class LikeUnlikeController extends GetxController {
  final userCookie = AuthToken();
  final numberofLikes = RxInt(0);
  final statusCode = RxInt(0);
  final liked = RxBool(false);

  Future<void> likeUnlike(String postID) async {
    String url = "${baseURL()}/api/posts/like/$postID";
    String postUrl = "${baseURL()}/api/posts/$postID";

    try {
      final authToken = await userCookie.getToken();
      final headers = {
        'Content-Type': 'application/json',
        'cookie': 'jwt=$authToken',
      };

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
      );
      statusCode.value = response.statusCode;

      if (response.statusCode == 200) {
        final postResponse = await http.get(Uri.parse(postUrl));
        print("The response body: ${postResponse.body}");
        statusCode.value = postResponse.statusCode;
        if (postResponse.statusCode == 200) {
          print("likeUnlike operation is successful");
        }
      } else {
        print(
            "Error in the likeUnlike function with statusCode: ${response.statusCode}");
      }
    } catch (error) {
      print("Error in the likeUnlike function: $error");
    }
  }
}
