import 'package:baby_milestone_app/constant/textStyle.dart';
import 'package:baby_milestone_app/screen/edit_username.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../commonwidget/appbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userAccountBox = Hive.box('user_box');

  String? storedParentName;
  String? storedChildName;
  String? storedChildAge;

  Future<void> retrieveData() async {
    // Retrieve the stored data from Hive
    storedParentName = userAccountBox.get('parentname');
    storedChildName = userAccountBox.get('childname');
    storedChildAge = userAccountBox.get('childage');

    setState(() {}); // Update the UI with the retrieved data
  }

  @override
  void initState() {
    super.initState();
    retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BuildAppBar(title: "My profile", icon: Icons.sunny),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const BuildProfileWidget(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Coding with ${storedChildName ?? "Azeez Aminu Olamide"}"
                      .toUpperCase(),
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  storedParentName ?? 'Azeez Aminu Olamide',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: backGBcolor,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    onPressed: () {
                      // Get.to(() => const EditProfile());
                    },
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                ProfileWidget(
                  icon: LineAwesomeIcons.cog,
                  onpress: () {},
                  title: 'Settings',
                ),
                ProfileWidget(
                  icon: LineAwesomeIcons.wallet,
                  onpress: () {},
                  title: 'Analytic Details',
                ),
                ProfileWidget(
                  icon: LineAwesomeIcons.user_check,
                  onpress: () {},
                  title: 'User Mnagement',
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileWidget(
                  icon: LineAwesomeIcons.info,
                  onpress: () {},
                  title: 'Information',
                ),
                ProfileWidget(
                  endIcon: false,
                  icon: LineAwesomeIcons.alternate_sign_out,
                  onpress: () async {
                    // await controller.logout();
                  },
                  title: 'Logout',
                ),
              ],
            ),
          ),
        ));
  }
}

class BuildProfileWidget extends StatelessWidget {
  const BuildProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/baby.jpg',
                fit: BoxFit.cover,
              )),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: InkWell(
            onTap: () {
              Get.to(() => const EditUserName());
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100), color: backGBcolor),
              child: const Icon(
                LineAwesomeIcons.alternate_pencil,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onpress;
  final bool endIcon;
  final Color? textcolor;
  const ProfileWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onpress,
    this.endIcon = true,
    this.textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.amber.withOpacity(0.1)),
        child: Icon(icon, color: backGBcolor),
      ),
      title: GestureDetector(
        onTap: onpress,
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1)),
              child: const Icon(
                LineAwesomeIcons.angle_right,
                size: 18,
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}
