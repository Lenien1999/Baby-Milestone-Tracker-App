import 'package:flutter/material.dart';

import '../constant/textStyle.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData icon;
  const BuildAppBar({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        title,
        style: appStyle(size: 16, fw: FontWeight.bold, color: backGBcolor),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: backGBcolor,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
