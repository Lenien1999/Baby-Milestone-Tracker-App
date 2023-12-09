import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constant/bottombar_navigation.dart';

import '../constant/textStyle.dart';
import '../model/onboarmodel.dart';

import 'onboard.dart';

// ignore: must_be_immutable
class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int currentPage = 0;

  late LiquidController controller;

  @override
  void initState() {
    super.initState();
    controller = LiquidController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pages = [
      OnBoardPage(
        model: OnboardModel(
          size: size.height * 0.5,
          title: 'Best Tracker',
          subtitle: 'Track your data and symptoms day by day',
          image: 'assets/images/baby1.jpg',
          counterText: '1/3',
        ),
      ),
      OnBoardPage(
        model: OnboardModel(
          size: size.height * 0.5,
          title: 'Milestone',
          subtitle: 'Track your baby Milestone',
          image: 'assets/images/baby.jpg',
          counterText: '2/3',
        ),
      ),
      OnBoardPage(
        model: OnboardModel(
          size: size.height * 0.5,
          title: 'Community Support',
          subtitle: 'Strong Community Support',
          image: 'assets/images/baby3.jpg',
          counterText: '3/3',
        ),
      ),
    ];

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            liquidController: controller,
            pages: pages,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
            onPageChangeCallback: onPageChangeCallback,
          ),
          Positioned(
              bottom: 60,
              child: OutlinedButton(
                onPressed: () {
                  int nextPage = controller.currentPage + 1;
                  controller.animateToPage(page: nextPage);
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.black26),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20)),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: backGBcolor, shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              )),
          Positioned(
              top: 50,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white)),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (__) {
                        return const BottomNavigation();
                      }));
                    },
                    // onPressed: () => controller.jumpToPage(page: 2),
                    child: const Text(
                      "Skip",
                      style: TextStyle(color: Colors.white),
                    )),
              )),
          Positioned(
              bottom: 10,
              child: AnimatedSmoothIndicator(
                activeIndex: controller.currentPage,
                count: 3,
                effect: const WormEffect(
                    activeDotColor: Color(0xff272727), dotHeight: 5.0),
              ))
        ],
      ),
    );
  }

  void onPageChangeCallback(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;
    });
  }
}
