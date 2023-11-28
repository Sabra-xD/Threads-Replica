import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/followUnfollowController.dart';
import 'package:threads_replica/controller/singleUserPostsController.dart';
import 'package:threads_replica/styles/TextStyles.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/views/posts/post_template.dart';

import '../controller/bottomNavigationBarController.dart';
import '../controller/userInfo.dart';

// ignore: must_be_immutable
class UsersProfileScreen extends StatelessWidget {
  Map<String, dynamic> fullUserInfo;
  String? userId;
  UsersProfileScreen({super.key, required this.fullUserInfo, this.userId});

  @override
  Widget build(BuildContext context) {
    FolloweController followeController = Get.put(FolloweController());

    // ignore: no_leading_underscores_for_local_identifiers
    BottomNavigationBarController _barController =
        Get.find<BottomNavigationBarController>();

    // ignore: no_leading_underscores_for_local_identifiers
    findUserPosts _findUserPosts = Get.put(findUserPosts());
    UserInfo userInfo = Get.find<UserInfo>();
    RxBool isFollowing =
        RxBool(fullUserInfo['followers'].contains(userInfo.userId.value));
    print("Is the user following? ${isFollowing.value}");
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: primaryColor,
          onPressed: () {
            Get.toNamed("/HomePage");
            _barController.updateIndex(0);
          },
        ),
      ),
      backgroundColor: mobileBackgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12.5),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        fullUserInfo['username']! ?? "Username",
                        style: defaultTextStyle(fontSize: 25),
                      ),
                      CircleAvatar(
                        foregroundImage: NetworkImage(fullUserInfo[
                                'profilePic'] ??
                            "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                        radius: 25,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "${fullUserInfo['followers']?.length ?? "Not read"}  followers",
                    style: defaultTextStyle(textColor: Colors.grey),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  //The Text will be wrapepd in an OBX.

                  ElevatedButton(onPressed: () async {
                    await followeController.FollowOrUnFollow(
                        fullUserInfo['_id']);
                    if (followeController.statusCode.value == 200) {
                      isFollowing.value = !isFollowing.value;
                    }
                  }, child: Obx(() {
                    return Text(
                      isFollowing.value ? "Unfollow" : "Follow",
                      style: defaultTextStyle(textColor: Colors.black),
                    );
                  })),

                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Threads: ",
                        style: defaultTextStyle(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.5,
                  ),
                  finderUserThreads(
                      findUserPosts: _findUserPosts, fullUserInfo: fullUserInfo)
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}

// ignore: camel_case_types
class finderUserThreads extends StatelessWidget {
  const finderUserThreads({
    super.key,
    required findUserPosts findUserPosts,
    required this.fullUserInfo,
  }) : _findUserPosts = findUserPosts;

  final findUserPosts _findUserPosts;
  final Map<String, dynamic> fullUserInfo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _findUserPosts.findPosts(fullUserInfo['_id']),
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
              if (_findUserPosts.posts.isEmpty) {
                return Center(
                  child: Text(
                    "No threads to show...",
                    style: defaultTextStyle(
                        fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: _findUserPosts.posts.length,
                  itemBuilder: (context, int index) {
                    final feedItem = _findUserPosts.posts[index];
                    print("FeedItem: ${feedItem['_id']}");
                    return PostTemplate(
                      fullUserInfo: fullUserInfo,
                      likedColor:
                          false, //We have to check, does it contain our user?
                      postID: feedItem['_id'],
                      text: feedItem['text'],
                      img: feedItem['profilePic'],
                      username: feedItem['username'],
                      likesCount: feedItem['likes'].length,
                      repliesCount: feedItem['replies'].length,
                      postPic: feedItem['img'],
                    );
                  },
                );
              }
            }
          }
        });
  }
}
