// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/PostController.dart';
import 'package:threads_replica/controller/userInfo.dart';
import 'package:threads_replica/views/users_profile_screen.dart';
import 'package:threads_replica/widgets/drop_down_delete.dart';
import 'package:threads_replica/widgets/flush_bar.dart';

import '../../controller/likeunlikeController.dart';
import '../../styles/TextStyles.dart';
import '../../utils/colors.dart';

// ignore: must_be_immutable
class PostTemplate extends StatelessWidget {
  String? text;
  String? username;
  String postedBy;
  String? img;
  int? likesCount;
  String postID;
  int? repliesCount;
  String? postPic;
  bool? likedColor;
  Map<String, dynamic> fullUserInfo;
  //We might need a dynamic variable here to have full user info so we can pass it to the
  //It includes all the information that we need though.
  //The issue here is, do we know what is the type? Yes Map<dynamic,String>

  PostTemplate({
    super.key,
    this.text,
    this.username,
    this.img,
    this.repliesCount,
    this.likesCount,
    this.postPic,
    required this.postedBy,
    required this.postID,
    this.likedColor,
    required this.fullUserInfo,
  });

  @override
  Widget build(BuildContext context) {
    final LikeUnlikeController _likeController =
        Get.put(LikeUnlikeController());
    RxBool liked = RxBool(likedColor!);
    RxInt varLikesCount = RxInt(likesCount!);
    RxInt varRepliesCount = RxInt(repliesCount!);
    UserInfo _userInfo = Get.find<UserInfo>();
    PostController _postController = Get.put(PostController());
    _likeController.numberofLikes.value = likesCount!;

    return Column(
      children: [
        const SizedBox(
          height: 12.5,
        ),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  foregroundImage: img != null && img != ""
                      ? NetworkImage(img!)
                      : const NetworkImage(
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                  radius: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    //Get to the User Page.
                    //Didn't we already get that user's info before?
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UsersProfileScreen(
                                  fullUserInfo: fullUserInfo,
                                )));
                  },
                  child: Text(
                    username ?? "Username",
                    overflow: TextOverflow.fade,
                    style: defaultTextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
                Text(
                  "5m",
                  style: defaultTextStyle(fontWeight: FontWeight.w600),
                ),
                _userInfo.userId.value == postedBy
                    ? DropDownMenu(
                        postID: postID,
                        replyID: "",
                        menuOptions: const ["Delete"],
                        onSelected: (String value) async {
                          //Delete Post here
                          await _postController.deletePost(postID);
                          if (_postController.deleteStatusCode.value == 200) {
                            flushBar("Post Deleted Sucessfully",
                                    Colors.lightBlue)
                                .show(context);
                          } else {
                            flushBar("Something went wrong..", Colors.redAccent)
                                .show(context);
                          }
                        },
                      )
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 55,
                    ),
                    SizedBox(
                      width: 200,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          text ?? "...",
                          softWrap: true,
                          maxLines: 5,
                          textAlign: TextAlign.center,
                          style: defaultTextStyle(
                              fontWeight: FontWeight.w300, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(child: displayImage(postPic)),
                Row(
                  children: [
                    Obx(() {
                      return IconButton(
                        color: liked.value
                            ? const Color.fromRGBO(255, 82, 82, 1)
                            : null, //Setting its color.
                        onPressed: () async {
                          //Basically we have a list that contains all the liked posts.
                          //We color them accordingly.
                          //Then we control the count through that as well.

                          await _likeController.likeUnlike(postID);
                          if (_likeController.statusCode.value == 200) {
                            if (liked.value) {
                              varLikesCount.value = varLikesCount.value - 1;
                            } else {
                              varLikesCount.value = varLikesCount.value + 1;
                            }
                            liked.value = !liked.value;
                          }
                        },
                        icon: const Icon(Icons.favorite_outline),
                      );
                    }),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.comment_bank_outlined)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.reply)),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
                Obx(() {
                  return Text(
                    "  ${varRepliesCount.value} replies . ${varLikesCount.value} likes",
                    style: defaultTextStyle(
                        fontWeight: FontWeight.w200, fontSize: 12),
                  );
                })
              ],
            )
          ],
        ),
        const Divider(
          thickness: 0.5,
          color: primaryColor,
        ),
        const SizedBox(
          height: 12.5,
        )
      ],
    );
  }

  Widget displayImage(postPic) {
    if (postPic != null) {
      return Image.network(
        postPic,
        height: 200,
        width: 200,
        fit: BoxFit.contain,
      );
    } else {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
  }
}
