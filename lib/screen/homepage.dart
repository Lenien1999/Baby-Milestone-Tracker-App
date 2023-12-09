import 'package:baby_milestone_app/commonwidget/category_widget.dart';
import 'package:baby_milestone_app/constant/carousel_model.dart';
import 'package:baby_milestone_app/constant/carousel_slider.dart';
import 'package:baby_milestone_app/constant/textStyle.dart';
import 'package:baby_milestone_app/screen/addmilestone.dart';
import 'package:baby_milestone_app/screen/profile.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../commonwidget/appbar.dart';
import '../model/category_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController _controller = CarouselController();
  int currentPage = 0;
  DateTime selectedValue = DateTime.now();
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
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: backGBcolor,
          onPressed: () {
            Get.to(() => const AddMilestonePage());
          },
          label: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      appBar: const BuildAppBar(
        title: 'DashBoard',
        icon: Icons.notifications,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            CarouselSlider.builder(
              carouselController: _controller,
              itemCount: carouselList.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                final item = carouselList[itemIndex];
                return CarouselSliderWidget(item: item);
              },
              options: CarouselOptions(
                  height: 155,
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  onPageChanged: (val, _) {
                    setState(() {
                      currentPage = val;
                    });
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(23),
                      bottomRight: Radius.circular(23))),
              child: Row(
                children: [
                  const BuildProfileWidget(),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          storedParentName ?? 'Azeez Aminu Olamide',
                          style: appStyle(
                                  size: 16,
                                  fw: FontWeight.bold,
                                  color: backGBcolor)
                              .copyWith(letterSpacing: 2),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                            "Child Name: ${storedChildName ?? 'Azeez Aminu Olamide'}",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ))),
                        Text("Child Age: ${storedChildAge ?? '12'}",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ))),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            BuildCategoryWidget(milestoneTypeList: milestoneTypeList),
            const SizedBox(
              height: 8,
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
