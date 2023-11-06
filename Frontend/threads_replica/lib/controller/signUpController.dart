import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> signIp(username, email, name, password, bio) async {
  const String url = "http://localhost:3000/api/users/login";

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final Map<String, String> data = {
    'username': username,
    'email': email,
    'name': name,
    'password': password,
    'bio': bio,
  };

  if (username != null && password != null && name != null) {
    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(data));

      if (response.statusCode == 200) {
        print("Response Data:${response.body}");
      } else {
        print("Error: ${response.body}");
      }
    } catch (error) {
      print(error);
    }
  } else {
    print("Post was failed due to insuficient input.");
  }
}
