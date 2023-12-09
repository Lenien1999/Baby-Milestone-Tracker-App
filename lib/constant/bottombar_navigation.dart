import 'package:baby_milestone_app/constant/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'screencontroller.dart';

// ignore: must_be_immutable
class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScreenController());
    return GetBuilder<ScreenController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),
          bottomNavigationBar: SafeArea(
              child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomNavWidget(
                  icon: controller.pageIndex == 0
                      // ignore: deprecated_member_use
                      ? FontAwesomeIcons.home
                      : FontAwesomeIcons.houseMedical,
                  onTap: () {
                    controller.pageChange(0);
                  },
                ),
                BottomNavWidget(
                  icon: controller.pageIndex == 1
                      ? FontAwesomeIcons.calendar
                      : Icons.calendar_month,
                  onTap: () {
                    controller.pageChange(1);
                  },
                ),
                BottomNavWidget(
                  icon: controller.pageIndex == 2
                      ? FontAwesomeIcons.info
                      : Icons.info_outline,
                  onTap: () {
                    controller.pageChange(2);
                  },
                ),
                BottomNavWidget(
                  icon: controller.pageIndex == 3
                      ? FontAwesomeIcons.person
                      : FontAwesomeIcons.user,
                  onTap: () {
                    controller.pageChange(3);
                  },
                ),
              ],
            ),
          )),
          body: controller.pageList[controller.pageIndex],
        );
      },
    );
  }
}

class BottomNavWidget extends StatelessWidget {
  final void Function()? onTap;
  final IconData icon;
  const BottomNavWidget({
    super.key,
    this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 36,
        width: 36,
        child: Icon(icon, color: backGBcolor),
      ),
    );
  }
}
