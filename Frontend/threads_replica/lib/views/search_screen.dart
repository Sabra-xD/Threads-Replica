// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/styles/TextStyles.dart';
import 'package:threads_replica/utils/colors.dart';
import '../controller/bottomNavigationBarController.dart';
import "../controller/searchController.dart";

import '../controller/userInfo.dart';
import '../widgets/text_input_field.dart';
import 'users_profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _search = TextEditingController();
  UserInfo userInfo = Get.find<UserInfo>();

  final searchController _searchController = Get.put(searchController());
  final BottomNavigationBarController _barController =
      Get.find<BottomNavigationBarController>();
  RxBool searched = RxBool(false);
  RxBool isrefreshed = RxBool(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: const Text(
          'Search',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.w300),
        ),
      ),
      backgroundColor: mobileBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Form(
                    autovalidateMode: AutovalidateMode.disabled,
                    key: _formKey,
                    child: TextFieldInput(
                      textEditingController: _search,
                      hintText: "Enter the username to find",
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the username";
                        }
                        return null;
                      },
                    )),
                const SizedBox(
                  height: 12.5,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // await _searchController.search(_search.text);
                        searched.value = true;
                        isrefreshed.toggle();
                      }
                    },
                    child: Text(
                      "Search",
                      style: defaultTextStyle(textColor: Colors.black),
                    )),
                const SizedBox(
                  height: 12.5,
                ),
                Obx(() {
                  if (searched.value &&
                      (isrefreshed.value == false ||
                          isrefreshed.value == true)) {
                    return FutureBuilder(
                        future: _searchController.search(_search.text),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            );
                          } else {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  "Error: ${snapshot.error}",
                                  style: defaultTextStyle(),
                                ),
                              );
                            } else {
                              print(
                                  "Result: ${_searchController.matchingUsers}");
                              if (_searchController.matchingUsers.isEmpty) {
                                return Center(
                                  child: Text(
                                    "No users were found",
                                    style: defaultTextStyle(fontSize: 25),
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        _searchController.matchingUsers.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final feedItem = _searchController
                                          .matchingUsers[index];

                                      return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UsersProfileScreen(
                                                            fullUserInfo:
                                                                feedItem)));

                                            _search.clear();
                                          },
                                          child: Row(
                                            children: [
                                              //User image:
                                              CircleAvatar(
                                                foregroundImage: NetworkImage(
                                                  feedItem['profilePic'] ??
                                                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                                                ),
                                                radius: 27,
                                              ),

                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "${feedItem["username"]}",
                                                    style: defaultTextStyle(
                                                        fontSize: 17),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${feedItem['bio']}",
                                                    style: defaultTextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),

                                              ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    feedItem['followers']
                                                            .contains(userInfo
                                                                .userId.value)
                                                        ? "UnFollow"
                                                        : "Follow",
                                                    style: defaultTextStyle(
                                                        textColor:
                                                            Colors.black),
                                                  )),
                                            ],
                                          ));
                                    });
                              }
                            }
                          }
                        });
                  } else {
                    return const SizedBox(
                      height: 0,
                      width: 0,
                    );
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
