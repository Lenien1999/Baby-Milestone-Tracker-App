import 'package:baby_milestone_app/constant/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../commonwidget/appbar.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  Map<String, double> dataMap = {
    "Language": 5,
    "Physical": 3,
    "Cognitive": 2,
    "Health Related": 2,
  };
  List<Color> colorList = [
    const Color.fromRGBO(223, 250, 92, 1),
    const Color.fromRGBO(129, 250, 112, 1),
    const Color.fromRGBO(129, 182, 205, 1),
    const Color.fromRGBO(91, 253, 199, 1),
    const Color.fromRGBO(175, 63, 62, 1.0),
    const Color.fromRGBO(254, 154, 92, 1),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppBar(title: 'Analytics', icon: Icons.edit),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Milestone Statistics',
              style:
                  appStyle(size: 18, fw: FontWeight.bold, color: backGBcolor),
            ),
            const SizedBox(height: 16),
            _buildStatItem('Total Milestones', '150'),
            const Divider(),
            _buildStatItem('Completed Milestones', '120'),
            const Divider(),
            _buildStatItem('Upcoming Milestones', '30'),
            const Divider(),
            _buildStatItem('Milestone Completion Rate', '80%'),
            const Divider(),
            SizedBox(
              height: 40,
            ),
            PieChart(
              baseChartColor: backGBcolor,
              dataMap: dataMap,
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              colorList: colorList,
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 32,
              centerText: "HYBRID",
              legendOptions: const LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
                decimalPlaces: 1,
              ),
              // gradientList: ---To add gradient colors---
              // emptyColorGradient: ---Empty Color gradient---
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildStatItem(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
