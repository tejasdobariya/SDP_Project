import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class PieChartContent extends StatefulWidget {
  late String email;
  int travel=0;
  int general=0;
  int bills=0;
  int food=0;
  int medical=0;
  int education=0;
  int total=0;

  PieChartContent({Key? key, required this.email,required this.total,required this.travel,required this.bills,required this.food,required this.medical,required this.education,required this.general}):super(key: key);

  @override
  State<PieChartContent> createState() => _PieChartContentState();
}

class _PieChartContentState extends State<PieChartContent> {
  List<PieChartSectionData> getSectionData(double screenWidth) {
    double radius = screenWidth / 2.4;

    return [
      PieChartSectionData(
        value:10,
        title: 'Bills ${widget.bills/widget.total}',
        radius: radius,
        color: Color(0xffed733f),
      ),
      PieChartSectionData(
        value: 10,
        title: 'Food ${widget.food/widget.total}',
        radius: radius,
        color: Color(0xff584f84),
      ),
      PieChartSectionData(
        value: 10,
        title: 'Medical ${widget.medical/widget.total}',
        radius: radius,
        color: Color(0xffd86f9b),
      ),
      PieChartSectionData(
        value: 30,
        title: 'Education ${widget.education/widget.total}',
        radius: radius,
        color: Color(0xffa2663e),
      ),
      PieChartSectionData(
        value: 20 ,
        title: 'Travel ${widget.travel/widget.total}',
        radius: radius,
        color: Colors.grey,
      ),
      PieChartSectionData(
        value:20,
        title: 'General ${widget.general/widget.total}',
        radius: radius,
        color: Colors.red,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(PieChartData(
        centerSpaceRadius: 0,
        sectionsSpace: 0,
        sections: getSectionData(MediaQuery.of(context).size.width)));
  }
}