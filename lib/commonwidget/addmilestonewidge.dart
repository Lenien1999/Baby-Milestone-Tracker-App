import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../constant/textStyle.dart';
import '../screen/addmilestone.dart';

class AddMilestoneWidget extends StatelessWidget {
  const AddMilestoneWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(23),
      child: DottedBorder(
          strokeWidth: 2,
          color: Colors.deepPurpleAccent,
          borderType: BorderType.RRect,
          radius: const Radius.circular(24),
          dashPattern: [5, 4],
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: backGBcolor,
              borderRadius: const BorderRadius.all(Radius.circular(24)),
            ),
            child: MaterialButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                onPressed: () {
                  Get.to(() => const AddMilestonePage());
                },
                child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.add,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8),
                      Text('Add Milestone',
                          style: TextStyle(
                            color: Colors.white,
                          ))
                    ])),
          )),
    );
  }
}
