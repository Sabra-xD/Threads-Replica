// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/replyController.dart';
import 'package:threads_replica/controller/userInfo.dart';
import 'package:threads_replica/styles/TextStyles.dart';
import '../../widgets/drop_down_delete.dart';

// ignore: must_be_immutable
class ReplyTemplate extends StatelessWidget {
  String replyText;
  String postID;
  String userID;
  String replyID;
  ReplyTemplate(
      {super.key,
      required this.replyText,
      required this.postID,
      required this.userID,
      required this.replyID});

  @override
  Widget build(BuildContext context) {
    final ReplyController _replyController = Get.put(ReplyController());
    UserInfo _userInfo = Get.find<UserInfo>();
    final List<String> menuOptions = ['Delete'];

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // //avatar
                        CircleAvatar(
                          foregroundImage: _replyController.userImg == ""
                              ? const NetworkImage(
                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png")
                              : NetworkImage(_replyController.userImg),
                          radius: 20,
                        ),
                        const SizedBox(
                          width: 12.5,
                        ),
                        Text(
                          _replyController.repliedUser,
                          style: defaultTextStyle(),
                        ),

                        _userInfo.userId.value == userID
                            ? DropDownMenu(
                                postID: postID,
                                replyID: replyID,
                                menuOptions: menuOptions,
                                onSelected: (String value) async {
                                  print("Removing reply");
                                  await _replyController.deleteReply(
                                      postID, replyID);
                                  print("Reply removed with postiD :${postID}");

                                  print("Selected ${value}");
                                },
                              )
                            : const SizedBox(
                                height: 0,
                                width: 0,
                              )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 50,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Text(
                            replyText,
                            softWrap: true,
                            maxLines: 3,
                            style: defaultTextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            }
          },
        ));
  }
}
