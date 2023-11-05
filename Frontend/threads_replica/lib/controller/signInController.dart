import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> confirmSignIn(username, password) async {
  const String url = "http://localhost:3000/api/users/login";

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final Map<String, String> data = {
    'username': username,
    'password': password,
  };

  final response = await http.post(Uri.parse(url),
      headers: headers, body: json.encode(data));

  if (response.statusCode == 200) {
    print("Response Data:${response.body}");
  } else {
    print("Error: ${response.body}");
  }
}
