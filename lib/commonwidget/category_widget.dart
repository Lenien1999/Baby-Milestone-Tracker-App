import 'package:baby_milestone_app/constant/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/category_model.dart';
import '../screen/milestone_typeScreen.dart';

class BuildCategoryWidget extends StatelessWidget {
  const BuildCategoryWidget({
    Key? key,
    required this.milestoneTypeList,
  }) : super(key: key);
  final List<MilestoneType> milestoneTypeList;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 0),
      child: GridView.builder(
        padding: const EdgeInsets.only(left: 25.0, right: 25, top: 0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: milestoneTypeList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 15,
          mainAxisExtent: 120,
          crossAxisSpacing: 20,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final category = milestoneTypeList[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => MilesStoneTypeScreen(
                    category: category,
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 238, 232, 232),
                    blurRadius: 1,
                    spreadRadius: 1,
                  )
                ],
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: size.height * 0.13, // Adjust this height
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      color: const Color.fromRGBO(235, 235, 235, 1),
                      child: Image.asset(
                        milestoneTypeList[index].image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(milestoneTypeList[index].type,
                        style: appStyle(
                            size: 12, fw: FontWeight.w500, color: backGBcolor)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
