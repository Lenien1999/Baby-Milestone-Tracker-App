import 'package:baby_milestone_app/commonwidget/appbar.dart';
import 'package:baby_milestone_app/constant/bottombar_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../constant/build_textfield.dart';
import '../constant/textStyle.dart';

class EditUserName extends StatefulWidget {
  const EditUserName({super.key});

  @override
  State<EditUserName> createState() => _EditUserNameState();
}

class _EditUserNameState extends State<EditUserName> {
  final userAccountBox = Hive.box('user_box');

  final childName = TextEditingController();
  final _key = GlobalKey<FormState>();
  final parentName = TextEditingController();
  final childAge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppBar(
          title: 'Edit User', icon: FontAwesomeIcons.userCheck),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerMilestone("Mother's Name"),
                BuildTextField(
                  icon: FontAwesomeIcons.userDoctor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Parent name cannot be empty';
                    }
                    return null;
                  },
                  hint: 'Mother Name',
                  controller: parentName,
                ),
                const SizedBox(
                  height: 15,
                ),
                headerMilestone("Child's Name"),
                BuildTextField(
                  icon: FontAwesomeIcons.userDoctor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Child name cannot be empty';
                    }
                    return null;
                  },
                  hint: "Child's Name",
                  controller: childName,
                ),
                const SizedBox(
                  height: 15,
                ),
                headerMilestone("Child's Age"),
                BuildTextField(
                  icon: FontAwesomeIcons.child,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Child Age cannot be empty';
                    }
                    return null;
                  },
                  hint: 'Child Age',
                  controller: childAge,
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: backGBcolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          saveData();
                          Get.offAll(() => const BottomNavigation());
                        }
                      },
                      child: const Text(
                        'Add UserAccount',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveData() async {
    // Save the entered data into Hive
    await userAccountBox.put('parentname', parentName.text);
    await userAccountBox.put('childname', childName.text);
    await userAccountBox.put('childage', childAge.text);
  }

  headerMilestone(String title) {
    return Text(
      title,
      style: appStyle(size: 14, fw: FontWeight.w600, color: backGBcolor),
    );
  }
}
