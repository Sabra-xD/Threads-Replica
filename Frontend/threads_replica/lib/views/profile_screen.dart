import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/userInfo.dart';
import 'package:threads_replica/styles/TextStyles.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/widgets/bottom_navigation_bar.dart';

import '../controller/bottomNavigationBarController.dart';

class ProfileScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    UserInfo _userInfo = Get.put(UserInfo());
    // ignore: no_leading_underscores_for_local_identifiers
    final BottomNavigationBarController _barController =
        Get.put(BottomNavigationBarController());
    return Scaffold(
      bottomNavigationBar: bottomNavBar(barController: _barController),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.lock_outline),
          color: primaryColor,
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.camera_alt_sharp,
              color: primaryColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu_open_outlined,
              color: primaryColor,
            ),
          ),
        ],
      ),
      backgroundColor: mobileBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder(
            future: _userInfo.fetchData(), // Initiate data fetching
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.lightBlue,
                  ),
                );
              } else {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      // Handle error case
                    ),
                  );
                } else {
                  return GetBuilder<UserInfo>(
                    init: _userInfo,
                    builder: (controller) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      controller.userName.value,
                                      style: defaultTextStyle(),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "0 followers",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 69, 69, 69),
                                      ),
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  foregroundImage: controller.img.value != ""
                                      ? NetworkImage(controller.img.value)
                                      : const NetworkImage(
                                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                                        ), // Add a default image URL
                                  radius: 25,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 35,
                                    width: 170,
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
                                    width: 170,
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
                          ),
                          // Add more UI elements as needed based on controller values
                          //...
                        ],
                      );
                    },
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
