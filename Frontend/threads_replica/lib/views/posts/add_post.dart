import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threads_replica/controller/createPostController.dart';
import 'package:threads_replica/controller/userInfo.dart';
import 'package:threads_replica/utils/colors.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
          ),
          title: const Text(
            'New thread',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.w300),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: mobileBackgroundColor,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            TextButton(
                onPressed: () {},
                child: const Text(
                  "Your followers can reply",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w400),
                )),
            ElevatedButton(
              onPressed: () {
                // Focus.of(context).unfocus();
                //Get the cookie, send it along with the postID of the user.
                createPost.createPost();

                print("Pressed on the POST button");
                if (_formKey.currentState!.validate()) {
                  createPost.createPost();
                }
              },
              child: const Text(
                'Post',
                style: TextStyle(
                    color: mobileBackgroundColor, fontWeight: FontWeight.w600),
              ),
            ),
          ]),
        ),
        body: Column(
          children: [
            const Divider(thickness: 0.5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: FutureBuilder(
                  future: Future.wait(
                      [_userInfo.getUserName(), _userInfo.getUserProfile()]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Error: ${snapshot.error}",
                            style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 25),
                          ),
                        );
                      } else {
                        final img = snapshot.data![1] ??
                            "https://c8.alamy.com/comp/2E915TB/glitch-error-404-computer-page-anaglyph-glitch-404-banner-error-layout-effect-screen-2E915TB.jpg";

                        final username = snapshot.data?[0] ?? "Username";
                        return Row(
                          children: [
                            CircleAvatar(
                              foregroundImage:
                                  NetworkImage(img), // Add a default image URL
                              radius: 25,
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Text(
                              username, // Replace with a default username or a placeholder
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          ],
                        );
                      }
                    }
                  }),
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
                          },
                          controller: createPost.threadText,
                          decoration: const InputDecoration(
                            hintText: 'Start a thread...',
                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                          style: const TextStyle(
                              fontSize: 14, color: primaryColor),
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
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
