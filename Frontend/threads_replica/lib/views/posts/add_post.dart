import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threads_replica/controller/createPostController.dart';
import 'package:threads_replica/controller/userInfo.dart';
import 'package:threads_replica/utils/colors.dart';

import '../../controller/bottomNavigationBarController.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key});

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final createPostController createPost = Get.put(createPostController());
  final UserInfo _userInfo = Get.put(UserInfo());
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Future<String> userName;
  Future<Object>? getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? "Username";
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBarController _barController =
        Get.put(BottomNavigationBarController());
    return GestureDetector(
      onTap: () {
        // Focus.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: mobileBackgroundColor,
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
            'New thread',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.w300),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: mobileBackgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Your followers can reply",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Focus.of(context).unfocus();
                  //Get the cookie, send it along with the postID of the user.
                  createPost.createPost();
                  if (_formKey.currentState!.validate()) {
                    createPost.createPost();
                    if (createPost.statusCode.value == 200) {
                      Flushbar(
                        backgroundColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadows: const [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                        padding: const EdgeInsets.all(15),
                        messageText: const Text(
                          "Post was created sucessfully",
                          style:
                              TextStyle(fontSize: 12, color: Colors.lightBlue),
                        ),
                        duration: const Duration(seconds: 2),
                      ).show(context);
                    } else {
                      Flushbar(
                        backgroundColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadows: const [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                        padding: const EdgeInsets.all(15),
                        messageText: const Text(
                          "Error...Please try again later.",
                          style:
                              TextStyle(fontSize: 12, color: Colors.redAccent),
                        ),
                        duration: const Duration(seconds: 2),
                      ).show(context);
                    }
                  }
                },
                child: const Text(
                  'Post',
                  style: TextStyle(
                    color: mobileBackgroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
          future: _userInfo.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.lightBlue,
                ),
              );
            } else {
              return Column(
                children: [
                  const Divider(thickness: 0.5),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          foregroundImage: NetworkImage(
                            _userInfo.img.value,
                          ), // Add a default image URL
                          radius: 25,
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Text(
                          _userInfo.userName.value,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.19,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter the required text";
                                  }
                                  return null;
                                },
                                controller: createPost.threadText,
                                decoration: const InputDecoration(
                                  hintText: 'Start a thread...',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  border: InputBorder.none,
                                ),
                                maxLines: null,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                                cursorColor: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
