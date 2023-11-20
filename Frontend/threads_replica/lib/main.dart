import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/updateUserProfile.dart';
import 'package:threads_replica/views/forgot_password.dart';
import 'package:threads_replica/views/home_screen.dart';
import 'package:threads_replica/views/login_screen.dart';
import 'package:threads_replica/views/posts/add_post.dart';
import 'package:threads_replica/views/posts/single_post_screen.dart';
import 'package:threads_replica/views/posts/test.dart';
import 'package:threads_replica/views/profile/edit_bio.dart';
import 'package:threads_replica/views/profile/edit_profile.dart';
import 'package:threads_replica/views/profile_screen.dart';
import 'package:threads_replica/views/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SinglePostScreen();
  }
}
