import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_replica/controller/replyController.dart';

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
                    print("Posting the reply was sucessful");
                    // ignore: use_build_context_synchronously
                    Flushbar(
                      backgroundColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadows: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                      padding: const EdgeInsets.all(15),
                      messageText: const Text(
                        "Reply was posted sucessfully",
                        style: TextStyle(fontSize: 12, color: Colors.lightBlue),
                      ),
                      duration: const Duration(seconds: 2),
                    ).show(context);
                  } else {
                    // ignore: use_build_context_synchronously
                    print(
                        "Reply Controller StatusCode: ${replyController.statusCode.value}");
                    // ignore: use_build_context_synchronously
                    Flushbar(
                      backgroundColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadows: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                      padding: const EdgeInsets.all(15),
                      messageText: const Text(
                        "Error in posting the reply",
                        style: TextStyle(fontSize: 12, color: Colors.redAccent),
                      ),
                      duration: const Duration(seconds: 2),
                    ).show(context);
                  }
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
