import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/bottomNavigationBarController.dart';
import 'package:threads_replica/controller/feedController.dart';
import 'package:threads_replica/styles/TextStyles.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/views/posts/post_template.dart';
import 'package:threads_replica/views/posts/single_post_screen.dart';
import 'package:threads_replica/widgets/bottom_navigation_bar.dart';
import 'package:threads_replica/widgets/threads_logo.dart';

class HomePage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final feedController _feedController = Get.put(feedController());
    final BottomNavigationBarController _barController =
        Get.put(BottomNavigationBarController());
    //The problem here is we need to await for the _userInfo to read the data we've saved in sharedPrferences.
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      bottomNavigationBar: bottomNavBar(barController: _barController),
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
                                      _feedController.combinedData[index];
                                  final liked =
                                      _feedController.userInLikes[index];

                                  print("Feed Item: ${feedItem}");
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SinglePostScreen(
                                                          feedItem: feedItem,
                                                          liked: liked)));

                                          _feedController.dispose();
                                        },
                                        child: PostTemplate(
                                          likedColor:
                                              liked, //We have to check, does it contain our user?
                                          postID: feedItem[0]['_id'],
                                          text: feedItem[0]['text'],
                                          img: feedItem[1]['profilePic'],
                                          username: feedItem[1]['username'],
                                          likesCount:
                                              feedItem[0]['likes'].length,
                                          repliesCount:
                                              feedItem[0]['replies'].length,
                                          postPic: feedItem[0]['img'],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // _buildReplyTemp(feedItem),
                                    ],
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
