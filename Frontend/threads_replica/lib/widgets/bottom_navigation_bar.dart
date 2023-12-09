// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/bottomNavigationBarController.dart';

import '../controller/getUserProfileController.dart';
import '../controller/userInfo.dart';
import '../views/users_profile_screen.dart';

class bottomNavBar extends StatelessWidget {
  const bottomNavBar({
    super.key,
    required BottomNavigationBarController barController,
  }) : _barController = barController;

  final BottomNavigationBarController _barController;

  @override
  Widget build(BuildContext context) {
    GetUserProfile _getUserProfile = Get.put(GetUserProfile());
    UserInfo _userInfo = Get.find<UserInfo>();
    return Obx(
      () => BottomNavigationBar(
        // elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        currentIndex: _barController.selectedIndex.value,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (index) async {
          _barController.updateIndex(index);
          if (index == 0) {
            Get.offAllNamed("/HomePage");
          }

          if (index == 1) {
            Get.offAllNamed("/SearchScreen");
          }

          if (index == 2) {
            Get.offAllNamed("/CreatePostScreen");
          }
          if (index == 3) {
            await _getUserProfile.getUserProfile(_userInfo.userId.value);
            // Get.offAllNamed("/ProfileScreen");
            print("The response data: ${_getUserProfile.responseData.value}");

            // This is the actual solution.
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => UsersProfileScreen(
                  fullUserInfo: _getUserProfile.responseData.value,
                ),
              ),
              (Route<dynamic> route) =>
                  false, // Route predicate always returns false, removes all existing routes
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.post_add,
            ),
            label: "Post",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile"),
        ],
      ),
    );
  }
}
