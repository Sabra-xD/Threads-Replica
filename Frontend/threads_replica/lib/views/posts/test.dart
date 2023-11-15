import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/signInController.dart';
import '../../controller/userInfo.dart'; // Adjust this path

class YourWidget extends StatelessWidget {
  final UserInfo _userInfo = Get.put(UserInfo());
  final SignInController signInController = Get.put(SignInController());
  final RxString username = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _userInfo.getUserName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            username.value = snapshot.data.toString();

            return Center(
              child: Column(
                children: [
                  TextFormField(
                    controller: signInController.usernameController,
                  ),
                  TextFormField(
                    controller: signInController.passwordController,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await signInController.confirmSignIn();
                      await signInController.confirmSignIn();
                      final updatedUsername = await _userInfo.getUserName();
                      username.value = updatedUsername.toString();
                    },
                    child: Text("Submit"),
                  ),
                  Obx(() {
                    return Text(
                      username.value,
                      style: TextStyle(fontSize: 18),
                    );
                  })
                ],
              ),
            );
          }
        }
      },
    ));
  }
}
