import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../styles/TextStyles.dart';
import '../../utils/colors.dart';

// ignore: must_be_immutable
class PostTemplate extends StatelessWidget {
  String? text;
  String? username;
  String? img;
  int? likesCount;
  int? repliesCount;
  // String? postPic;
  PostTemplate(
      {super.key,
      this.text,
      this.username,
      this.img,
      this.repliesCount,
      this.likesCount});

  @override
  Widget build(BuildContext context) {
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
                  foregroundImage: NetworkImage(
                      //Here we need to fetch every user's profile picture from the DB.
                      img ??
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
                // Center(child: displayImage(postPic)),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_outline),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.comment_bank_outlined)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.reply)),
                  ],
                ),

                Text(
                  "  ${repliesCount} replies . ${likesCount} likes",
                  style: defaultTextStyle(
                      fontWeight: FontWeight.w200, fontSize: 12),
                ),
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
    if (postPic != '') {
      return SizedBox(
        width: 100,
        height: 100,
        child: Image.network(postPic),
      );
    } else {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
  }
}
