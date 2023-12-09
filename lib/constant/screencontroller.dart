import 'package:baby_milestone_app/screen/anlytic_screen.dart';
import 'package:baby_milestone_app/screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/milestone_page.dart';
import '../screen/profile.dart';

class ScreenController extends GetxController {
  int pageIndex = 0;
  List<Widget> pageList = [
    const HomePage(),
    AnalyticsPage(),
    const MileStonePage(),
    const ProfilePage(),
  ];

  void pageChange(int index) {
    pageIndex = index;
    update();
  }
}
