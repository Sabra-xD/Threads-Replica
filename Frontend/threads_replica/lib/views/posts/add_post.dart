import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/createPostController.dart';
import 'package:threads_replica/utils/colors.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final createPostController createPost = Get.put(createPostController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextEditingController _titleController = TextEditingController();
  // TextEditingController _postController = TextEditingController();
  // TextEditingController _tagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          TextButton(
              onPressed: () {},
              child: const Text(
                "Your followers can reply",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
              )),
          ElevatedButton(
            onPressed: () {
              // Handle thread creation here
              // String title = _titleController.text;
              // String postContent = _postController.text;
              // String tags = _tagsController.text;
              // You can do something with the thread details, e.g., send them to a server
              // print('Thread Created: $title, $postContent, $tags');

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
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              children: [
                const CircleAvatar(
                  foregroundImage: NetworkImage(
                      "https://static.vecteezy.com/system/resources/thumbnails/001/840/618/small/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-free-vector.jpg"), // Add a default image URL
                  radius: 25,
                ),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Username", // Replace with a default username or a placeholder
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: primaryColor),
                      ),
                      Form(
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
                      Row(
                        children: [
                          //Group of Icons.
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
