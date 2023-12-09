import 'package:baby_milestone_app/constant/textStyle.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'carousel_model.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({
    super.key,
    required this.item,
  });

  final CarouselModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.only(top: 12, right: 12, left: 12, bottom: 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: backGBcolor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: appStyle(
                          size: 16, fw: FontWeight.bold, color: Colors.white)
                      .copyWith(letterSpacing: 2),
                ),
                Text(item.subtitle,
                    maxLines: 4,
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12))),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Image.asset(
                item.image,
                height: 100,
                fit: BoxFit.fitHeight,
              ))
        ],
      ),
    );
  }
}

class CarouselDot extends StatelessWidget {
  const CarouselDot({
    super.key,
    required CarouselController controller,
    required this.currentPage,
  }) : _controller = controller;

  final CarouselController _controller;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: carouselList.asMap().entries.map((entry) {
        return InkWell(
          onTap: () {
            _controller.animateToPage(entry.key);
          },
          child: Container(
            width: 12.0,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentPage == entry.key ? backGBcolor : Colors.grey,
            ),
          ),
        );
      }).toList(),
    );
  }
}
