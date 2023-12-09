import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threads_replica/controller/PostController.dart';
import 'package:threads_replica/controller/userInfo.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:threads_replica/widgets/text_input_field.dart';

import '../../controller/bottomNavigationBarController.dart';

class PostScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const PostScreen({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PostController createPost = Get.put(PostController());
  final UserInfo _userInfo = Get.find<UserInfo>();
  RxBool addPic = RxBool(false);
  TextEditingController picLink = TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Future<String> userName;
  Future<Object>? getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? "Username";
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final BottomNavigationBarController _barController =
        Get.put(BottomNavigationBarController());
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        backgroundColor: mobileBackgroundColor,
        appBar: AppBar(
          elevation: 2,
          backgroundColor: mobileBackgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.close),
            color: primaryColor,
            onPressed: () {
              Get.offAllNamed("/HomePage");
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await createPost.createPost(picLink.text);
                    if (createPost.createPoststatusCode.value == 200) {
                      // ignore: use_build_context_synchronously
                      await Flushbar(
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
                          "Post was created successfully",
                          style:
                              TextStyle(fontSize: 12, color: Colors.lightBlue),
                        ),
                        duration: const Duration(seconds: 2),
                      ).show(context);

                      Get.offAllNamed("/HomePage");
                      _barController.updateIndex(0);

                      createPost.threadText.clear();
                      createPost.dispose();
                    } else {
                      // ignore: use_build_context_synchronously
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
                          ),
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
                        onPressed: () {
                          addPic.toggle();
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  Obx((() {
                    if (addPic.value) {
                      return TextFieldInput(
                          textEditingController: picLink,
                          hintText: "Enter the picture's link",
                          textInputType: TextInputType.text);
                    } else {
                      return const SizedBox(
                        height: 0,
                        width: 0,
                      );
                    }
                  }))
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
