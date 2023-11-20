import 'package:flutter/material.dart';

import '../../styles/TextStyles.dart';
import '../../utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostTemplate extends StatelessWidget {
  const PostTemplate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: SvgPicture.network(
          'https://upload.wikimedia.org/wikipedia/commons/9/9d/Threads_%28app%29_logo.svg',
          width: 50,
          height: 50,
          color: primaryColor,
          placeholderBuilder: (BuildContext context) =>
              const CircularProgressIndicator(
            color: Colors.blue,
          ),
        )),
        const SizedBox(
          height: 12.5,
        ),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  foregroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                  radius: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "User name",
                  style: defaultTextStyle(fontWeight: FontWeight.w600),
                ),
                Spacer(),
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
                Text(
                  "This is how my post would look like!",
                  style: defaultTextStyle(
                      fontWeight: FontWeight.w300, fontSize: 15),
                ),
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
                )
              ],
            )
          ],
        ),
        const Divider(
          thickness: 0.5,
          color: primaryColor,
        ),
      ],
    );
  }
}
