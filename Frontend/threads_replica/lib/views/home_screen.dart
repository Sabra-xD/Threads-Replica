import 'package:flutter/material.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/views/posts/post_template.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(12.5),
          //We should wrap up the Post Template in a Future Builder that has a List View Child.
          //Future Builder basically fetches the information from the BE and sends it it to the ListView and them ListView displays multiple instances of the PostTemplate.
          //So, we start off by creating the API call.
          // child: PostTemplate(),
        )),
      ),
    );
  }
}
