import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/updateUserProfile.dart';
import 'package:threads_replica/views/profile/edit_profile.dart';
import 'package:threads_replica/widgets/text_input_field.dart';

import '../../styles/TextStyles.dart';
import '../../utils/colors.dart';

class EditPasswordScreen extends StatelessWidget {
  const EditPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final updateUser = Get.find<updateUserProfileController>();
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _passwordChange = TextEditingController();
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _confirmPassword = TextEditingController();
    // ignore: no_leading_underscores_for_local_identifiers
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: primaryColor,
          onPressed: () {
            updateUser.dispose();
          },
        ),
        title: Text(
          'Edit Password',
          style: defaultTextStyle(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (_passwordChange.text.length < 6) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Password must be 6 characters or more",
                        style: defaultTextStyle(),
                      ),
                      duration: const Duration(seconds: 2),
                    ));
                  } else {
                    if (_passwordChange.text != _confirmPassword.text) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Password is a mismatch',
                          style: defaultTextStyle(),
                        ),
                        duration: const Duration(seconds: 2),
                      ));
                    } else {
                      //Navigate to edit
                      updateUser.newPasswordController = _confirmPassword;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen()));
                    }
                  }
                }
              },
              icon: const Icon(
                Icons.check_sharp,
                color: primaryColor,
              ))
        ],
      ),
      body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
        padding: const EdgeInsets.all(12.5),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldInput(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please fill the required field";
                      }
                      return null;
                    },
                    textEditingController: _passwordChange,
                    hintText: "Enter your new password",
                    textInputType: TextInputType.text),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please fill the required field";
                    }
                    return null;
                  },
                  textEditingController: _confirmPassword,
                  hintText: "Confirm your password",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            )),
      ))),
    );
  }
}
