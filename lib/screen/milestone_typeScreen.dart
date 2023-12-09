import 'package:baby_milestone_app/commonwidget/addmilestonewidge.dart';
import 'package:baby_milestone_app/screen/milestone_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../commonwidget/appbar.dart';
import '../constant/textStyle.dart';
import '../model/category_model.dart';

class MilesStoneTypeScreen extends StatefulWidget {
  final MilestoneType category;
  const MilesStoneTypeScreen({super.key, required this.category});

  @override
  State<MilesStoneTypeScreen> createState() => _MilesStoneTypeScreenState();
}

class _MilesStoneTypeScreenState extends State<MilesStoneTypeScreen> {
  Future<List<dynamic>> _fetchMilestones() async {
    final milestoneBox = await Hive.openBox('milestone_box');
    final DateFormat formatter = DateFormat("yyyy-MM-dd");
    List<dynamic> milestones = milestoneBox.keys.map((key) {
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

    milestones = milestones.reversed.toList();
    return milestones;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BuildAppBar(
            title: '${widget.category.type} Milestone',
            icon: FontAwesomeIcons.userAstronaut),
        body: FutureBuilder(
            future: _fetchMilestones(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                return const Center(child: AddMilestoneWidget());
              } else {
                List<dynamic> milestones = snapshot.data as List<dynamic>;
                List filterMilestonesByType = milestones
                    .where((element) => element['type'] == widget.category.type)
                    .toList();

                if (filterMilestonesByType.isEmpty) {
                  return const Center(child: AddMilestoneWidget());
                }
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                      itemCount: filterMilestonesByType.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        final data = filterMilestonesByType[index];
                        return InkWell(
                          onTap: () {
                            Get.to(() => MilestoneDetails(milestone: data));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                  )
                                ],
                                border: Border.all(
                                    width: 1,
                                    color: const Color.fromARGB(
                                        255, 224, 222, 222)),
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white),
                            child: SizedBox(
                              height: 250,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          'assets/images/baby1.jpg',
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                        Positioned(
                                            left: 10,
                                            top: 10,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: backGBcolor,
                                                    width: 1),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(23),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  data['type'],
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: backGBcolor),
                                                ),
                                              ),
                                            )),
                                        Positioned(
                                            right: 20,
                                            bottom: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1),
                                                color: backGBcolor,
                                                borderRadius:
                                                    BorderRadius.circular(23),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 10),
                                                child: Text(
                                                  data['milestone'],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data['notes'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: appStyle(
                                              color: const Color.fromRGBO(
                                                  28, 31, 52, 1),
                                              fw: FontWeight.w500,
                                              size: 16,
                                            ),
                                          ),
                                          Text(
                                            data['date'] != null
                                                ? DateFormat.yMMMEd().format(
                                                    DateTime.parse(
                                                        data['date']))
                                                : '',
                                            style: appStyle(
                                              color: const Color.fromRGBO(
                                                  28, 31, 52, 1),
                                              fw: FontWeight.w500,
                                              size: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
                );
              }
            }));
  }
}
