import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/feedController.dart';
import 'package:threads_replica/styles/TextStyles.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/views/posts/post_template.dart';
import 'package:threads_replica/widgets/threads_logo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final feedController _feedController = Get.put(feedController());

    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.5),
          child: Column(
            children: [
              const ThreadsLogo(),
              Expanded(
                child: FutureBuilder(
                  future: _feedController.getFeed(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      );
                    } else {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "${snapshot.error}",
                            style: defaultTextStyle(),
                          ),
                        );
                      } else {
                        return _feedController.receivedData.isEmpty
                            ? Center(
                                child: Text(
                                  "Nothing to display!",
                                  style: defaultTextStyle(),
                                ),
                              )
                            : ListView.builder(
                                itemCount: _feedController.receivedData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final feedItem =
                                      _feedController.receivedData[index];
                                  final username =
                                      _feedController.usernames[index];

                                  return PostTemplate(
                                    text: feedItem['text'],
                                    img: feedItem['img'],
                                    username: username,
                                  );
                                },
                              );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
