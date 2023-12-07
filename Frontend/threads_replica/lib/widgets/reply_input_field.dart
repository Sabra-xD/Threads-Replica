// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/replyController.dart';
import 'package:threads_replica/widgets/flush_bar.dart';

import '../styles/TextStyles.dart';

Widget buildTextFormField(TextEditingController reply, BuildContext context,
    ReplyController replyController, String postID) {
  RxBool replywritten = RxBool(false);
  final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    borderSide: const BorderSide(color: Colors.grey),
  );
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: reply,
      style: const TextStyle(color: Colors.white),
      onChanged: (_) {
        if (reply.text.isEmpty) {
          replywritten.value = false;
        } else {
          replywritten.value = true;
        }
      },
      decoration: InputDecoration(
          suffixIcon: Obx(() {
            return IconButton(
              color: replywritten.value ? Colors.white : null,
              icon: const Icon(Icons.arrow_forward),
              onPressed: () async {
                if (replywritten.value) {
                  //Post the reply
                  await replyController.postReply(postID, reply.text);
                  if (replyController.statusCode.value == 200) {
                    reply.clear();
                    flushBar("Reply created sucessfully", Colors.lightBlue)
                        .show(context);
                  } else {
                    flushBar("Something went wrong...", Colors.redAccent)
                        .show(context);
                  }
                  await Future.delayed(const Duration(milliseconds: 3000));
                  FocusScope.of(context).unfocus();
                }
              },
            );
          }),
          hintText: 'Your comment here...',
          hintStyle: defaultTextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            textColor: Colors.white.withOpacity(0.5),
          ),
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder),
    ),
  );
}
