import 'package:baby_milestone_app/constant/bottombar_navigation.dart';
import 'package:baby_milestone_app/constant/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class MilestoneDetails extends StatelessWidget {
  final Map<String, dynamic> milestone;
  const MilestoneDetails({
    super.key,
    required this.milestone,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: backGBcolor,
      height: size.height,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0x00f6f7f9),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: size.height,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            SizedBox(
                              height: size.height * 0.5,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: size.height * 0.39,
                                    width: size.width,
                                    child: Image.asset(
                                      'assets/images/baby.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      left: 20,
                                      right: 20,
                                      child: Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.09),
                                                  blurRadius: 1,
                                                  offset: Offset(0, 1),
                                                  spreadRadius: 2)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.transparent),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(milestone['type'],
                                                      style: appStyle(
                                                          size: 16,
                                                          fw: FontWeight.w500,
                                                          color: Colors.white)),
                                                  Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: backGBcolor),
                                                  Text(milestone['milestone'],
                                                      style: appStyle(
                                                          size: 16,
                                                          fw: FontWeight.bold,
                                                          color: Colors.white)),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              Row(
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                        text: milestone[
                                                            'milestone'],
                                                        style: textStyle(
                                                            size: 16,
                                                            fw: FontWeight.bold,
                                                            color: backGBcolor),
                                                        children: [
                                                          TextSpan(
                                                              text: '10% off',
                                                              style: appStyle(
                                                                  size: 16,
                                                                  fw: FontWeight
                                                                      .w500,
                                                                  color: Colors
                                                                      .white))
                                                        ]),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Date:',
                                                      style: textStyle(
                                                          size: 16,
                                                          fw: FontWeight.bold,
                                                          color: Colors.black)),
                                                  Text(
                                                      milestone['date'] != null
                                                          ? DateFormat.yMMMEd()
                                                              .format(DateTime
                                                                  .parse(milestone[
                                                                      'date']))
                                                          : '',
                                                      style: appStyle(
                                                          size: 14,
                                                          fw: FontWeight.bold,
                                                          color: Colors.black)),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Parenting:',
                                                      style: appStyle(
                                                          size: 14,
                                                          fw: FontWeight.bold,
                                                          color: Colors.black)),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.star,
                                                        size: 20,
                                                        color: Colors.amber,
                                                      ),
                                                      Text('4.5',
                                                          style: appStyle(
                                                              size: 14,
                                                              fw: FontWeight
                                                                  .w500,
                                                              color: Colors
                                                                  .black)),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                  const Positioned(
                                      top: 10,
                                      right: 10,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          FontAwesomeIcons.heart,
                                          color: Colors.grey,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Description',
                                      style: appStyle(
                                          size: 16,
                                          fw: FontWeight.bold,
                                          color: const Color.fromRGBO(
                                              28, 31, 52, 1))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(milestone['notes'],
                                      softWrap: true,
                                      style: appStyle(
                                          size: 14,
                                          fw: FontWeight.w500,
                                          color: const Color.fromRGBO(
                                              28, 31, 52, 1))),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 45.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: backGBcolor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () async {
                                _deleteMilestone(milestone['key']);
                                Get.offAll(() => const BottomNavigation());
                              },
                              child: const Text(
                                'Delete Milestone',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _deleteMilestone(int key) {
  final milestoneBox = Hive.box('milestone_box');
  milestoneBox.delete(key);
}

TextStyle textStyle(
    {required double size, required FontWeight fw, required Color color}) {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          color: color, fontWeight: fw, fontSize: size, letterSpacing: 1.5));
}
