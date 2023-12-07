import 'package:flutter/material.dart';

import '../utils/colors.dart';

class DropDownMenu extends StatelessWidget {
  const DropDownMenu({
    Key? key,
    required this.postID,
    required this.replyID,
    required this.menuOptions,
    required this.onSelected,
  }) : super(key: key);

  final String postID;
  final String replyID;
  final List<String> menuOptions;
  final void Function(String)? onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: mobileBackgroundColor,
      icon: const Icon(
        Icons.more_vert,
        color: primaryColor,
      ),
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return menuOptions.map((String option) {
          return PopupMenuItem<String>(
            value: option,
            child: Text(
              option,
              style: const TextStyle(color: Colors.redAccent, fontSize: 14),
            ),
          );
        }).toList();
      },
    );
  }
}
