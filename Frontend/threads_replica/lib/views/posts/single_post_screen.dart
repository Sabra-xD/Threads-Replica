import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/replyController.dart';
import 'package:threads_replica/utils/colors.dart';
import 'package:threads_replica/views/posts/post_template.dart';
import 'package:threads_replica/views/posts/reply_template.dart';

import '../../widgets/reply_input_field.dart';

class SinglePostScreen extends StatelessWidget {
  final List<dynamic> feedItem;
  final bool liked;

  const SinglePostScreen(
      {Key? key, required this.feedItem, required this.liked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final ReplyController _replyController = Get.put(ReplyController());
    TextEditingController reply = TextEditingController();
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
              _replyController.dispose();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.5),
                      child: PostTemplate(
                        likedColor: liked,
                        postID: feedItem[0]['_id'],
                        text: feedItem[0]['text'],
                        img: feedItem[1]['profilePic'],
                        username: feedItem[1]['username'],
                        likesCount: feedItem[0]['likes'].length,
                        repliesCount: feedItem[0]['replies'].length,
                        postPic: feedItem[0]['img'],
                      ),
                    ),
                    _buildReplyTemp(feedItem),
                  ],
                ),
              ),
            ),
          ),
          buildTextFormField(
              reply, context, _replyController, feedItem[0]['_id']),
        ],
      ),
    );
  }

  Widget _buildReplyTemp(List<dynamic> feedItem) {
    if (feedItem[0]['replies'].length > 0) {
      return Column(
        children: List.generate(feedItem[0]['replies'].length, (index) {
          final replyInfo = feedItem[0]['replies'][index];
          return ReplyTemplate(
            userID: replyInfo['userId'],
            replyText: replyInfo['text'],
          );
        }),
      );
    } else {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
  }
}
