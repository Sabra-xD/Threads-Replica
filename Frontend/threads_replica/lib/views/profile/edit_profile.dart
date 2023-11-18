import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/updateUserProfile.dart';
import 'package:threads_replica/controller/userInfo.dart';
import 'package:threads_replica/styles/TextStyles.dart';
import 'package:threads_replica/utils/colors.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    UserInfo _userInfo = Get.put(UserInfo());
    updateUserProfileController _updateUser = updateUserProfileController();

    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: primaryColor,
          onPressed: () {
            //Close the current page and route to the most recent page.
          },
        ),
        title: Text(
          'Edit Profile',
          style: defaultTextStyle(),
        ),
        actions: [
          TextButton(
              onPressed: () {
                //Post?
                _updateUser.updateProfile();
              },
              child: Text(
                "Done",
                style: defaultTextStyle(),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            // Center widget added
            child: SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.9, // Adjust width as needed
              child: GetBuilder<UserInfo>(
                init: _userInfo,
                builder: (controller) {
                  if (controller.isLoading.value) {
                    controller.fetchData();
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.lightBlue,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 52, 51, 51),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // Implement the change username functionality here.
                                        //We need to route to the need page first though.
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            "Name",
                                            style: defaultTextStyle(),
                                          ),
                                          Text(
                                            "  ${_userInfo.userName.value}",
                                            style: defaultTextStyle(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // Implement the add image functionality here.
                                      },
                                      child: CircleAvatar(
                                        foregroundImage: NetworkImage(
                                          controller.img.value,
                                        ),
                                        radius: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                thickness: 0.5,
                                color: primaryColor,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        Text(
                                          "Bio",
                                          style: defaultTextStyle(),
                                        ),
                                        Text(
                                          "+ Write Bio",
                                          style: defaultTextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 0.5,
                                color: primaryColor,
                              ),
                              Row(children: [
                                InkWell(
                                  onTap: () {
//Send request to change the password.
                                  },
                                  child: const Text("Update your password"),
                                )
                              ]),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
