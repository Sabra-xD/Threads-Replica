// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/updateUserProfile.dart';
import 'package:threads_replica/utils/colors.dart';

import 'package:threads_replica/views/profile/edit_profile.dart';

import '../../styles/TextStyles.dart';

class EditBioScreen extends StatelessWidget {
  EditBioScreen(
      {super.key,
      required this.username,
      required this.profilePic,
      required this.currentBio,
      required this.userID});
  String username;
  String userID;
  String profilePic;
  String currentBio;

  @override
  Widget build(BuildContext context) {
    final updateUser = Get.find<updateUserProfileController>();

    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: mobileBackgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.close),
            color: primaryColor,
            onPressed: () {
              Navigator.pop(context);
              // updateUser.dispose();
            },
          ),
          title: Text(
            'Edit Bio',
            style: defaultTextStyle(),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  print(
                      "Value of the bioController ${updateUser.bioController.text}");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                              username: username,
                              currentBio: currentBio,
                              userID: userID,
                              profilePic: profilePic,
                            )),
                    // Route predicate always returns false, removes all existing routes
                  );
                },
                icon: const Icon(
                  Icons.check_sharp,
                  color: primaryColor,
                ))
          ],
        ),
        backgroundColor: mobileBackgroundColor,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12.5),
            child: TextFormField(
              controller: updateUser.bioController,
              maxLines: null, // Allows the TextFormField to expand vertically
              style: const TextStyle(
                  color: primaryColor), // Sets text color to white
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: primaryColor),
                ),
                labelText: 'Bio',
                labelStyle:
                    const TextStyle(color: Colors.white), // Label text color
                hintText: 'Enter your bio',
                hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 75, 74, 74)), // Hint text color
              ),
            ),
          ),
        ));
  }
}
