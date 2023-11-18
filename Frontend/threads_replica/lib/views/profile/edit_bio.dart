import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/updateUserProfile.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/views/posts/add_post.dart';
import 'package:threads_replica/views/profile/edit_profile.dart';
import 'package:threads_replica/widgets/text_input_field.dart';

import '../../styles/TextStyles.dart';

class EditBioScreen extends StatelessWidget {
  EditBioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    updateUserProfileController _updateBio =
        Get.put(updateUserProfileController());
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: mobileBackgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.close),
            color: primaryColor,
            onPressed: () {
              //Close the current page and route to the most recent page.

              //Dispose of the _updateBioController.
              _updateBio.dispose();
            },
          ),
          title: Text(
            'Edit Bio',
            style: defaultTextStyle(),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  //Save the current Bio from the TextEditing Controller
                  //It is already saved. We just need to route back pretty much.

                  // Navigator.push(context);
                  print("Should be navigating");
                  print(_updateBio.bioController.text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen()));
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
              controller: _updateBio.bioController,
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
