import 'package:flutter/material.dart';
import 'package:expense_track/static.dart' as Static;
import 'package:expense_track/charts/pie_chart.dart';
import 'package:fl_chart/fl_chart.dart';


class LineBar extends StatefulWidget {
  String email;
   LineBar({Key? key, required this.email}) : super(key: key);

  @override
  State<LineBar> createState() => _ChartPieState(email);
}

class _ChartPieState extends State<LineBar> {
  DateTime today = DateTime.now();

  List<FlSpot> dataSet = [];
String email;
  _ChartPieState(this.email);

  List<FlSpot> getPlotPoints(Map entireData) {
    dataSet = [];
    entireData.forEach((key, value) {
      if (value['type'] == "Expense" &&
          (value['date'] as DateTime).month == today.month) {
        dataSet.add(
          FlSpot(
            (value['date'] as DateTime).day.toDouble(),
            (value['amount'] as int).toDouble(),
          ),
        );
      }
    });
    // return [
    //   FlSpot(1, 4),
    //   FlSpot(2, 9),
    //   FlSpot(3, 5),
    //   FlSpot(7, 15),
    // ];
    return dataSet;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      backgroundColor: Color(0xffe2e7ef),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "LineBar chart",
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w900,
                ),
              )),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                8.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 5,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 40.0,
            ),
            margin: EdgeInsets.all(12.0),
            height: 400.0,
            child: LineChart(
              LineChartData(
                borderData: FlBorderData(
                  show: false,
                ),
                lineBarsData: [
                  LineChartBarData(
                    // spots: getPlotPoints(snapshot.data!),
                      spots: [
                        FlSpot(1, 4),
                        FlSpot(2, 9),
                        FlSpot(3, 5),
                        FlSpot(7, 15),
                        FlSpot(8, 9),
                      ],
                      isCurved: false,
                      barWidth: 2.5,
                      colors: [
                        Static.PrimaryColor,
                      ]
                  ),
                ],
              ),
            ),
          ),

          Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextButton(
                child: Text(
                  "View by category",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChartPie(email:email),
                    ),
                  );
                },
              )
          ),
        ],
      ),
    );

  }
}
