import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/likeunlikeController.dart';
import '../../styles/TextStyles.dart';
import '../../utils/colors.dart';

// ignore: must_be_immutable
class PostTemplate extends StatelessWidget {
  String? text;
  String? username;
  String? img;
  int? likesCount;
  String postID;
  int? repliesCount;
  String? postPic;
  PostTemplate(
      {super.key,
      this.text,
      this.username,
      this.img,
      this.repliesCount,
      this.likesCount,
      this.postPic,
      required this.postID});

  @override
  Widget build(BuildContext context) {
    final likeunlikeController _likeController =
        Get.put(likeunlikeController());

    RxInt varLikesCount = RxInt(likesCount!);
    RxInt varRepliesCount = RxInt(repliesCount!);

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
                  foregroundImage: NetworkImage(img ??
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                  radius: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  username ?? "Username",
                  style: defaultTextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text(
                  "5m",
                  style: defaultTextStyle(fontWeight: FontWeight.w600),
                ),
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
                    Text(
                      text ?? "...",
                      style: defaultTextStyle(
                          fontWeight: FontWeight.w300, fontSize: 15),
                    ),
                  ],
                ),
                Center(child: displayImage(postPic)),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        await _likeController.likeunlike(postID);
//Remove this if somehow we made the likesCount update from the BE.
                        if (_likeController.statusCode.value == 200) {
                          varLikesCount.value = varLikesCount.value + 1;
                        }
                        if (_likeController.statusCode.value == 204) {
                          varLikesCount.value = varLikesCount.value - 1;
                        }
                      },
                      icon: const Icon(Icons.favorite_outline),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.comment_bank_outlined)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.reply)),
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
