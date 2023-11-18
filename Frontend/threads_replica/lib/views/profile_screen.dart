import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/userInfo.dart';
import 'package:threads_replica/styles/TextStyles.dart';
import 'package:threads_replica/utils/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserInfo _userInfo = Get.put(UserInfo());
    return Scaffold(
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
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu_open_outlined,
                  color: primaryColor,
                ))
          ],
        ),
        backgroundColor: mobileBackgroundColor,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Expanded(
            child: GetBuilder<UserInfo>(
              init: _userInfo,
              builder: (controller) {
                if (controller.isLoading.value) {
                  controller.fetchData();
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.lightBlue,
                  ));
                } else {
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
                                const Text("0 followers",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 69, 69, 69)))
                              ],
                            ),
                            CircleAvatar(
                              foregroundImage: NetworkImage(controller
                                  .img.value), // Add a default image URL
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
                                          color: primaryColor.withOpacity(
                                              0.5), // Outer edge color
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          // offset: Offset(3, 3),
                                        ),
                                      ]),
                                  child: Center(
                                      child: Text(
                                    "Edit Profile",
                                    style: defaultTextStyle(),
                                  ))),
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
                                          color: primaryColor.withOpacity(
                                              0.5), // Outer edge color
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          // offset: Offset(3, 3),
                                        ),
                                      ]),
                                  child: Center(
                                      child: Text(
                                    "Share Profile",
                                    style: defaultTextStyle(),
                                  ))),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          )),
        ));
  }
}
