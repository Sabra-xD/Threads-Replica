// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/suggestedUsersController.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/views/suggested_users.dart';
import 'package:threads_replica/widgets/drop_down_delete.dart';

import '../controller/bottomNavigationBarController.dart';
import '../controller/followUnfollowController.dart';
import '../controller/userInfo.dart';
import '../styles/TextStyles.dart';

AppBar personalAppBar(UserInfo _userInfo) {
  return AppBar(
    elevation: 2,
    backgroundColor: mobileBackgroundColor,
    leading: IconButton(
      icon: const Icon(Icons.lock_outline),
      color: primaryColor,
      onPressed: () {
        //Should display a list of users to follow
      },
    ),
    actions: [
      IconButton(
        onPressed: () async {
          FindSuggestUsers _findUsers = Get.put(FindSuggestUsers());
          await _findUsers.suggestedUsers();
          if (_findUsers.suggestedStatusCode.value == 200) {
            Get.to(() => SuggestedUsersScreen(
                  receivedData: _findUsers.receivedData,
                ));
          }
        },
        icon: const Icon(
          Icons.camera_alt_sharp,
          color: primaryColor,
        ),
      ),
      DropDownMenu(
          icon: const Icon(
            Icons.menu_open_outlined,
            color: primaryColor,
          ),
          postID: "",
          replyID: "",
          menuOptions: const ['Log out'],
          onSelected: (String option) async {
            //Clear the SharedPreferences.
            _userInfo.cleareSharedPrefs();
            SystemNavigator.pop();
          }),
    ],
  );
}

AppBar defaultProfileAppBar(BottomNavigationBarController _barController) {
  return AppBar(
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
  );
}

Padding editAndShareProfileButtons(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(12.5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Get.toNamed("/EditProfileScreen");
          },
          child: Container(
            height: 35,
            width: MediaQuery.of(context).size.width * 0.42,
            decoration: BoxDecoration(
              color: mobileBackgroundColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.5),
                  // Outer edge color
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Text(
                "Edit Profile",
                style: defaultTextStyle(),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            height: 35,
            width: MediaQuery.of(context).size.width * 0.42,
            decoration: BoxDecoration(
              color: mobileBackgroundColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.5),
                  // Outer edge color
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Text(
                "Share Profile",
                style: defaultTextStyle(),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

ElevatedButton followUnFollowButton(
    FolloweController followeController,
    RxBool isFollowing,
    RxInt numberOfFollowers,
    Map<String, dynamic> fullUserInfo) {
  return ElevatedButton(onPressed: () async {
    await followeController.FollowOrUnFollow(fullUserInfo['_id']);
    if (followeController.statusCode.value == 200) {
      if (isFollowing.value) {
        numberOfFollowers.value = numberOfFollowers.value - 1;
      } else {
        numberOfFollowers.value = numberOfFollowers.value + 1;
      }
      isFollowing.value = !isFollowing.value;
    }
  }, child: Obx(() {
    return Text(
      isFollowing.value ? "Unfollow" : "Follow",
      style: defaultTextStyle(textColor: Colors.black),
    );
  }));
}
