import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/replyController.dart';
import 'package:threads_replica/styles/TextStyles.dart';

// ignore: must_be_immutable
class ReplyTemplate extends StatelessWidget {
  String replyText;
  String userID;
  ReplyTemplate({super.key, required this.replyText, required this.userID});

  @override
  Widget build(BuildContext context) {
    final ReplyController _replyController = Get.put(ReplyController());
    return Container(
        padding: const EdgeInsets.all(12.5),
        child: FutureBuilder(
          future: _replyController.getUser(userID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 0,
                width: 0,
              );
            } else {
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Error: ${snapshot.error}",
                  style: defaultTextStyle(),
                ));
              } else {
                return Column(
                  children: [
                    Row(
                      children: [
                        // //avatar
                        CircleAvatar(
                          foregroundImage: NetworkImage(_replyController
                                  .userImg ??
                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                          radius: 20,
                        ),
                        const SizedBox(
                          width: 12.5,
                        ),
                        Text(
                          _replyController.repliedUser,
                          style: defaultTextStyle(),
                        ),

                        //Username
                      ],
                      //Text
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      replyText,
                      style: defaultTextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ],
                );
              }
            }
          },
        ));
  }
}
