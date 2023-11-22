import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';

class ThreadsLogo extends StatelessWidget {
  const ThreadsLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SvgPicture.network(
      'https://upload.wikimedia.org/wikipedia/commons/9/9d/Threads_%28app%29_logo.svg',
      width: 50,
      height: 50,
      // ignore: deprecated_member_use
      color: primaryColor,
    ));
  }
}
