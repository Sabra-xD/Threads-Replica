import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/getPostController.dart';
import 'package:threads_replica/styles/TextStyles.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/views/posts/post_template.dart';

class SinglePostScreen extends StatelessWidget {
  SinglePostScreen({super.key});
  final getSinglePostController _singlePostController =
      Get.put(getSinglePostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: SingleChildScrollView(
          child: SafeArea(
              child: FutureBuilder(
                  future: _singlePostController.getPost(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      );
                    } else {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Error: ${snapshot.error}",
                            style: defaultTextStyle(),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(12.5),
                          child: PostTemplate(
                              postID: "0",
                              text: _singlePostController.text,
                              username: _singlePostController.username,
                              img: _singlePostController.img),
                        );
                      }
                    }
                  }))),
    );
  }
}
