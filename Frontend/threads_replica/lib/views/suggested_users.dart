// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:threads_replica/utils/colors.dart';

import '../styles/TextStyles.dart';

class SuggestedUsersScreen extends StatelessWidget {
  SuggestedUsersScreen({super.key, required this.receivedData});

  List<dynamic> receivedData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mobileBackgroundColor,
        appBar: AppBar(
          elevation: 2,
          backgroundColor: mobileBackgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.close),
            color: primaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Suggested Users',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.w300),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.5),
          child: ListView.builder(
              itemCount: receivedData.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    //User image:
                    CircleAvatar(
                      foregroundImage: NetworkImage(
                        receivedData[index]['profilePic'] ??
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                      ),
                      radius: 27,
                    ),

                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          "${receivedData[index]["username"]}",
                          style: defaultTextStyle(fontSize: 17),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${receivedData[index]['bio']}",
                          style: defaultTextStyle(
                              fontSize: 10, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ));
  }
}
