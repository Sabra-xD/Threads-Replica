// ignore_for_file: use_super_parameters, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/getUserProfileController.dart';
import 'package:threads_replica/controller/updateUserProfile.dart';
import 'package:threads_replica/controller/userInfo.dart';
import 'package:threads_replica/styles/TextStyles.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/views/profile/edit_password.dart';
import 'package:threads_replica/widgets/text_input_field.dart';

import '../users_profile_screen.dart';
import 'edit_bio.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen(
      {Key? key,
      required this.username,
      required this.profilePic,
      required this.currentBio,
      required this.userID})
      : super(key: key);

  String username;
  String userID;
  String profilePic;
  String currentBio;
  @override
  Widget build(BuildContext context) {
    // UserInfo _userInfo = Get.put(UserInfo());
    updateUserProfileController _updateUser =
        Get.put(updateUserProfileController());
    UserInfo _userInfo = Get.put(UserInfo());
    GetUserProfile _getUserProfile = Get.put(GetUserProfile());

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

            Navigator.pop(context);
          },
        ),
        title: Text(
          'Edit Profile',
          style: defaultTextStyle(),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                print(
                    "Value of the bioController @ the Done button: ${_updateUser.bioController.text}");
                await _updateUser.updateProfile();
                if (_updateUser.statusCode.value == 200) {
                  _userInfo.saveBio(_updateUser.bioController.text);
                  _userInfo.savedImage(_updateUser.newImageController.text);
                  _updateUser.imageChanged.value = false;
                  await _getUserProfile.getUserProfile(userID);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UsersProfileScreen(
                        fullUserInfo: _getUserProfile.responseData.value,
                      ),
                    ),
                    (Route<dynamic> route) => false,
                  );
                  _updateUser.dispose();
                }
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
                                            "  $username",
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
                                        //We should have a TextField basically taking the link of the image.
                                        _updateUser.imageChanged.value = true;
                                      },
                                      child: CircleAvatar(
                                        foregroundImage: NetworkImage(
                                          profilePic,
                                        ),
                                        radius: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Obx(() {
                                print(
                                    "Value of the RXBool ${_updateUser.imageChanged.value}");
                                if (_updateUser.imageChanged.value) {
                                  return TextFieldInput(
                                      textEditingController:
                                          _updateUser.newImageController,
                                      hintText: "Enter the image's link",
                                      textInputType: TextInputType.text);
                                } else {
                                  return const SizedBox(
                                    height: 0,
                                    width: 0,
                                  );
                                }
                              }),
                              const Divider(
                                thickness: 0.5,
                                color: primaryColor,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditBioScreen(
                                                    username: username,
                                                    currentBio: currentBio,
                                                    userID: userID,
                                                    profilePic: profilePic,
                                                  )));
                                    },
                                    child: Column(
                                      children: [
                                        Text(
                                          "Bio",
                                          style: defaultTextStyle(),
                                        ),
                                        Text(
                                          currentBio != ""
                                              ? currentBio
                                              : "+ Write Bio",
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditPasswordScreen(
                                                  username: username,
                                                  currentBio: currentBio,
                                                  userID: userID,
                                                  profilePic: profilePic,
                                                )));
                                  },
                                  child: Text(
                                    "Update your password",
                                    style: defaultTextStyle(),
                                  ),
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
