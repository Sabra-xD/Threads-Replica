import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class getSinglePostController extends GetxController {
  String url = "http://10.0.2.2:3000/api/posts/655ae86f5badd658d0532063";
  RxInt StatusCode = RxInt(0);
  String _id = '';
  late String postedBy;
  String text = '';
  List likes = [];
  List replies = [];
  String creationTime = '';
  String img = '';
  String username = '';

  Future<void> getPost() async {
    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final response = await http.get(Uri.parse(url));
      print("This is the response of the getSinglePostController");
      StatusCode.value = response.statusCode;
      if (response.statusCode == 200) {
        Map<String, dynamic> receivedData = json.decode(response.body);

        _id = receivedData['post']['_id'];
        postedBy = receivedData['post']['postedBy'];
        text = receivedData['post']['text'];
        likes = receivedData['post']['likes'];
        replies = receivedData['post']['replies'];
        creationTime = receivedData['post']['createdAt'];
        print("ID: ${_id} postedBy: ${postedBy} text: ${text}");
        final Map<String, String> data = {'userID': postedBy};

        String getUserUrl = "http://10.0.2.2:3000/api/users/userbyid";
        final secondresponse = await http.post(Uri.parse(getUserUrl),
            headers: headers, body: json.encode(data));
        receivedData = json.decode(secondresponse.body);

        username = receivedData['username'];
        img = receivedData['profilePic'];

        //We've the user ID from postedBy now we fetch the user from the BE.
      } else {
        print("Error Status Code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error in the getSinglePostController : ${error}");
    }
  }
}
