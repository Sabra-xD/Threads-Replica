import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/userInfo.dart';
import 'package:threads_replica/views/forgot_password.dart';
import 'package:threads_replica/views/home_screen.dart';
import 'package:threads_replica/views/login_screen.dart';
import 'package:threads_replica/views/posts/add_post.dart';
import 'package:threads_replica/views/search_screen.dart';
import 'package:threads_replica/views/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Threads - Replica',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/SignInScreen", page: () => SignInScreen()),
        GetPage(name: "/SignUpScreen", page: () => SignUpScreen()),
        GetPage(
            name: "/ForogtPasswordScreen",
            page: () => const ForgotPasswordScreen()),
        GetPage(name: "/CreatePostScreen", page: () => const PostScreen()),
        GetPage(name: "/HomePage", page: () => const HomePage()),
        GetPage(name: "/SearchScreen", page: () => SearchScreen()),
        // GetPage(
        //     name: "/EditProfileScreen", page: () =>  EditProfileScreen()),
      ],
      home: const MyHomePage(title: 'Threads-Replica'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    UserInfo _userInfo = Get.put(UserInfo());
    return FutureBuilder(
      future: _userInfo.fetchData(), // Initialize and call fetchData
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        } else {
          if (_userInfo.userId.value != "") {
            return const HomePage();
          } else {
            return SignInScreen();
          }
        }
      },
    );
  }
}
