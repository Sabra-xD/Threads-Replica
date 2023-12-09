import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/followUnfollowController.dart';
import 'package:threads_replica/controller/singleUserPostsController.dart';
import 'package:threads_replica/styles/TextStyles.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/views/posts/post_template.dart';
import 'package:threads_replica/widgets/profile_widgets.dart';

import '../controller/bottomNavigationBarController.dart';
import '../controller/userInfo.dart';
import '../widgets/bottom_navigation_bar.dart';

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

    RxInt numberOfFollowers = RxInt(fullUserInfo['followers']?.length);

    // ignore: no_leading_underscores_for_local_identifiers
    findUserPosts _findUserPosts = Get.put(findUserPosts());
    UserInfo userInfo = Get.find<UserInfo>();
    RxBool isFollowing =
        RxBool(fullUserInfo['followers'].contains(userInfo.userId.value));
    return Scaffold(
      bottomNavigationBar: fullUserInfo['_id'] == userInfo.userId.value
          ? bottomNavBar(barController: _barController)
          : null,
      appBar: fullUserInfo['_id'] == userInfo.userId.value
          ? personalAppBar(userInfo)
          : defaultProfileAppBar(_barController),
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

                  Obx(() {
                    return Text(
                      "${numberOfFollowers.value}  followers",
                      style: defaultTextStyle(textColor: Colors.grey),
                    );
                  }),

                  Text(
                    "${fullUserInfo['following'].length} following",
                    style: defaultTextStyle(textColor: Colors.grey),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  //The Text will be wrapepd in an OBX.
                  fullUserInfo['_id'] == userInfo.userId.value
                      ? editAndShareProfileButtons(context)
                      : followUnFollowButton(followeController, isFollowing,
                          numberOfFollowers, fullUserInfo),

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
                    findUserPosts: _findUserPosts,
                    fullUserInfo: fullUserInfo,
                    userInfo: userInfo,
                  )
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
    required this.userInfo,
  }) : _findUserPosts = findUserPosts;

  final findUserPosts _findUserPosts;
  final Map<String, dynamic> fullUserInfo;
  final UserInfo userInfo;

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
                    return PostTemplate(
                      createdAt: feedItem['createdAt'],
                      fullUserInfo: fullUserInfo,
                      postedBy: feedItem['postedBy'],
                      likedColor: feedItem['likes'].contains(userInfo.userId
                          .value), //We have to check, does it contain our user?
                      postID: feedItem['_id'],
                      text: feedItem['text'],
                      img: fullUserInfo['profilePic'],
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
