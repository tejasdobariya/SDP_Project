import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_track/charts/pie_chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../pages/details.dart';
import 'chart_container.dart';

class ChartPie extends StatefulWidget {
  String email;

  ChartPie({Key? key, required this.email}) : super(key: key);

  @override
  State<ChartPie> createState() => _ChartPieState(email);
}

class _ChartPieState extends State<ChartPie> {
  String email;

  _ChartPieState(this.email);

  int travel = 0;
  int general = 0;
  int bills = 0;
  int food = 0;
  int medical = 0;
  int education = 0;
  int total = 0;

  Stream<List<Details>> readUsers() => FirebaseFirestore.instance
      .collection('expenses')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Details.fromJson(doc.data())).toList());

  Widget buildUser(Details detil) {
    // if (detil.type == "Expense" && detil.emailid == email) {
    //   if (detil.category == 'Travel') {
    //     travel += detil.amount;
    //   } else if (detil.category == 'General') {
    //     general += detil.amount;
    //   } else if (detil.category == 'Food') {
    //     food += detil.amount;
    //   } else if (detil.category == 'Medical') {
    //     medical += detil.amount;
    //   } else if (detil.category == 'Education') {
    //     education += detil.amount;
    //   } else {
    //     bills += detil.amount;
    //   }
    //   total += detil.amount;
    // }



    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      backgroundColor: Color(0xffe2e7ef),
      body: Container(
        color: Color(0xfff0f0f0),
        child: ListView(
          padding: EdgeInsets.fromLTRB(30, 100, 40, 30),
          children: <Widget>[
            StreamBuilder<List<Details>>(
                stream: readUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final txdatas = snapshot.data!;
                    List<Details> details = txdatas;
                    for(var detil in details) {
                      if (detil.type == "Expense" && detil.emailid == email) {
                        if (detil.category == 'Travel') {
                          travel += detil.amount;
                        } else if (detil.category == 'General') {
                          general += detil.amount;
                        } else if (detil.category == 'Food') {
                          food += detil.amount;
                        } else if (detil.category == 'Medical') {
                          medical += detil.amount;
                        } else if (detil.category == 'Education') {
                          education += detil.amount;
                        } else {
                          bills += detil.amount;
                        }
                        total += detil.amount;
                      }
                    }
                    return Column(
                      children: [
                        ChartContainer(
                          title: 'Spent on category',
                          color: Color(0xffe2e7ef),
                          chart: PieChartContent(
                              email: email,
                              total: total,
                              travel: travel,
                              bills: bills,
                              food: food,
                              medical: medical,
                              education: education,
                              general: general),
                        ),
                        // ListView(
                        //   shrinkWrap: true,
                        //   children: txdatas.map(buildUser).toList(),
                        // ),


                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class PieChartContent extends StatelessWidget {
  late String email;
  final int travel;
  final int general;
  final int bills;
  final int food;
  final int medical;
  final int education;
  final int total;

  PieChartContent(
      {Key? key,
      required this.email,
      required this.total,
      required this.travel,
      required this.bills,
      required this.food,
      required this.medical,
      required this.education,
      required this.general})
      : super(key: key);

  List<PieChartSectionData> getSectionData(double screenWidth) {
    double radius = screenWidth / 2.4;
    return [
      PieChartSectionData(
        value: bills/total,
        title: 'Bills ${(bills / total).toStringAsFixed(2)}',
        radius: radius,
        color: Color(0xffed733f),
      ),
      PieChartSectionData(
        value: food/total,
        title: 'Food ${(food / total).toStringAsFixed(2)}',
        radius: radius,
        color: Color(0xff584f84),
      ),
      PieChartSectionData(
        value: medical/total,
        title: 'Medical ${(medical / total).toStringAsFixed(2)}',
        radius: radius,
        color: Color(0xffd86f9b),
      ),
      PieChartSectionData(
        value: education/total,
        title: 'Education ${(education / total).toStringAsFixed(2)}',
        radius: radius,
        color: Color(0xffa2663e),
      ),
      PieChartSectionData(
        value: travel/total,
        title: 'Travel ${(travel / total).toStringAsFixed(2)}',
        radius: radius,
        color: Colors.grey,
      ),
      PieChartSectionData(
        value: (general / total),
        title: 'General ${(general / total).toStringAsFixed(2)}',
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
