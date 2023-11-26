import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/userInfo.dart';
import 'package:threads_replica/views/forgot_password.dart';
import 'package:threads_replica/views/home_screen.dart';
import 'package:threads_replica/views/login_screen.dart';
import 'package:threads_replica/views/posts/add_post.dart';
import 'package:threads_replica/views/profile_screen.dart';
import 'package:threads_replica/views/signup_screen.dart';

void main() {
  // Dart client
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        GetPage(name: "/CreatePostScreen", page: () => PostScreen()),
        GetPage(name: "/ProfileScreen", page: () => const ProfileScreen()),
        GetPage(name: "/HomePage", page: () => const HomePage()),
      ],
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
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
