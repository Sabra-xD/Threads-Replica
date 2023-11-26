import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/followUnfollowController.dart';
import 'package:threads_replica/styles/TextStyles.dart';
import 'package:threads_replica/utils/colors.dart';

import '../controller/userInfo.dart';

// ignore: must_be_immutable
class UsersProfileScreen extends StatelessWidget {
  Map<String, dynamic> fullUserInfo;
  UsersProfileScreen({super.key, required this.fullUserInfo});

  @override
  Widget build(BuildContext context) {
    FolloweController followeController = Get.put(FolloweController());
    UserInfo userInfo = Get.find<UserInfo>();
    RxBool isFollowing =
        RxBool(fullUserInfo['followers'].contains(userInfo.userId.value));
    print("Is the user following? ${isFollowing.value}");
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(12.5),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        fullUserInfo['username']! ?? "Username",
                        style: defaultTextStyle(fontSize: 25),
                      ),
                      CircleAvatar(
                        foregroundImage: NetworkImage(fullUserInfo[
                                'profilePic'] ??
                            "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                        radius: 25,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "${fullUserInfo['followers']?.length ?? "Not read"}  followers",
                    style: defaultTextStyle(textColor: Colors.grey),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
//The Text will be wrapepd in an OBX.

                  ElevatedButton(onPressed: () async {
                    await followeController.FollowOrUnFollow(
                        fullUserInfo['_id']);
                    if (followeController.statusCode.value == 200) {
                      isFollowing.value = !isFollowing.value;
                    }
                  }, child: Obx(() {
                    print("Initial isFollowing Value: ${isFollowing}");
                    return Text(
                      isFollowing.value ? "Unfollow" : "Follow",
                      style: defaultTextStyle(textColor: Colors.black),
                    );
                  })),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Threads: ",
                    style: defaultTextStyle(),
                  ),

                  //Display the Threads here inside another OBX.
                ],
              ),
//               FutureBuilder(
//                   future: profileController.getUserProfile("query"),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(
//                         child: CircularProgressIndicator(color: Colors.blue),
//                       );
//                     } else {
//                       if (snapshot.hasError) {
//                         return Center(
//                           child: Text(
//                             "Error: ${snapshot.error}",
//                             style: defaultTextStyle(),
//                           ),
//                         );
//                       } else {
//                         return Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Text(
//                                   "User name",
//                                   style: defaultTextStyle(),
//                                 ),
//                                 CircleAvatar(
//                                   foregroundImage: NetworkImage("Image"),
//                                   radius: 25,
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),

//                             //Number of Followers:
//                             Text(
//                               "10k followers ",
//                               style: defaultTextStyle(textColor: Colors.grey),
//                             ),

//                             const SizedBox(
//                               height: 10,
//                             ),
// //The Text will be wrapepd in an OBX.
//                             ElevatedButton(
//                                 onPressed: () {},
//                                 child: Text(
//                                   "Follow/Unfollow Button",
//                                   style:
//                                       defaultTextStyle(textColor: Colors.black),
//                                 )),

//                             const SizedBox(
//                               height: 10,
//                             ),

//                             Text(
//                               "Threads: ",
//                               style: defaultTextStyle(),
//                             ),

//                             //Display the Threads here inside another OBX.
//                           ],
//                         );
//                       }
//                     }
//                   })
            ],
          ),
        )),
      ),
    );
  }
}
