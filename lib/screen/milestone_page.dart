import 'package:baby_milestone_app/constant/textStyle.dart';
import 'package:baby_milestone_app/screen/addmilestone.dart';
import 'package:baby_milestone_app/screen/milestone_details.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../commonwidget/addmilestonewidge.dart';
import '../commonwidget/appbar.dart';

class MileStonePage extends StatefulWidget {
  const MileStonePage({super.key});

  @override
  State<MileStonePage> createState() => _MileStonePageState();
}

class _MileStonePageState extends State<MileStonePage> {
  late final Future<List<dynamic>> _milestoneData;

  @override
  void initState() {
    super.initState();
    _milestoneData = fetchMilestoneData();
  }

  Future<List<dynamic>> fetchMilestoneData() async {
    final milestoneBox = Hive.box('milestone_box');
    final DateFormat formatter = DateFormat("yyyy-MM-dd");

    final milestoneData = milestoneBox.keys.map((key) {
      final item = milestoneBox.get(key);
      final DateTime date = item['date'] != null
          ? DateTime.tryParse(item['date'] as String) ?? DateTime.now()
          : DateTime.now();
      return {
        'key': key,
        'type': item['type'],
        'date': formatter.format(date),
        'notes': item['notes'] ?? '',
        'milestone': item['milestone'] ?? '',
      };
    }).toList();

    return milestoneData.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppBar(
        title: 'Milestones',
        icon: FontAwesomeIcons.user,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<List<dynamic>>(
          future: _milestoneData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || (snapshot.data?.isEmpty ?? true)) {
              return const Center(
                child: AddMilestoneWidget(),
              );
            } else {
              final milestones = snapshot.data ?? [];
              return ListView(
                children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                          child: FadeInAnimation(child: widget),
                        ),
                    children: milestones
                        .map((data) => GestureDetector(
                              onTap: () {
                                Get.to(() => MilestoneDetails(milestone: data));
                              },
                              child: Container(
                                // padding: const EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(bottom: 12),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  //  width: SizeConfig.screenWidth * 0.78,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: backGBcolor,
                                  ),
                                  child: Row(children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${data['type']} Tracking ",
                                            style: GoogleFonts.lato(
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.access_time_rounded,
                                                color: Colors.grey[200],
                                                size: 18,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                data['date'] != null
                                                    ? DateFormat.yMMMEd()
                                                        .format(DateTime.parse(
                                                            data['date']))
                                                    : '',
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey[100]),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            data['notes'],
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  color: Colors.grey[100]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 60,
                                      width: 0.5,
                                      color: Colors.grey[200]!.withOpacity(0.7),
                                    ),
                                    RotatedBox(
                                      quarterTurns: 20,
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                Get.to(() => AddMilestonePage(
                                                      initialData: data,
                                                    ));
                                              },
                                              child: const Icon(Icons.edit,
                                                  color: Colors.white)),
                                          Text(
                                            "Edit",
                                            style: GoogleFonts.lato(
                                              textStyle: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ))
                        .toList()),
              );
            }
          },
        ),
      ),
    );
  }
}
