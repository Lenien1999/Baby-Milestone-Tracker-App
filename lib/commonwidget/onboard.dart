import 'package:baby_milestone_app/constant/textStyle.dart';
import 'package:flutter/material.dart';
 
import '../model/onboarmodel.dart';

class OnBoardPage extends StatelessWidget {
  const OnBoardPage({
    super.key,
    required this.model,
  });

  final OnboardModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.bottomRight, stops: const [
          0.1,
          0.9
        ], colors: [
          Colors.black.withOpacity(.8),
          Colors.black.withOpacity(.1)
        ]),
        image: DecorationImage(
          image: AssetImage(
            model.image,
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(1.0), BlendMode.softLight),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
          ),
          Column(
            children: [
              Text(
                model.title,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                model.subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.counterText,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: backGBcolor),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
