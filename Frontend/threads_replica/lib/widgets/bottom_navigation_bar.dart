// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/bottomNavigationBarController.dart';

class bottomNavBar extends StatelessWidget {
  const bottomNavBar({
    super.key,
    required BottomNavigationBarController barController,
  }) : _barController = barController;

  final BottomNavigationBarController _barController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        elevation: 10,
        backgroundColor: Colors.transparent,
        currentIndex: _barController.selectedIndex.value,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          _barController.updateIndex(index);
          if (index == 0) {
            Get.toNamed("/HomePage");
          }
          if (index == 1) {
            Get.toNamed("/CreatePostScreen");
          }
          if (index == 2) {
            Get.toNamed("/ProfileScreen");
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
