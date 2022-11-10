import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'details.dart';
import 'package:expense_track/charts/pie_chart.dart';
import 'package:expense_track/pages/add_transaction.dart';
import 'package:expense_track/pages/investment_suggestion.dart';
import 'package:expense_track/pages/select_category.dart';
import 'package:expense_track/pages/user_information.dart';
import 'package:expense_track/pages/view_transaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_track/static.dart' as Static;
import '../charts/linebar_chart.dart';

class HomePage extends StatefulWidget {
  final String email;

  const HomePage({Key? key, required this.email}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState(email);
}

class _HomePageState extends State<HomePage> {
  DateTime today = DateTime.now();
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  List<FlSpot> dataSet = [];
  String email;
  int val = 0;

  @override
  initState()
  {
    balance();
  }

  _HomePageState(this.email);

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
    return [
      FlSpot(1, 4),
      FlSpot(2, 9),
      FlSpot(3, 5),
      FlSpot(7, 15),
    ];
    return dataSet;
  }

  getTotalBalance(String type, int amount) {
    if (type == "Income") {
      totalBalance += amount;
      totalIncome += amount;
    } else {
      totalBalance -= amount;
      totalExpense += amount;
    }
  }

  List usertxnlist = [];

  Stream<List<Details>> readUsers() => FirebaseFirestore.instance
      .collection('expenses')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Details.fromJson(doc.data())).toList());

  Widget buildUser(Details detil) {
    if (detil.type == 'Income' && email == detil.emailid) {
      // getTotalBalance(detil.type, detil.amount);
      return incomeTile(detil.amount, detil.note, detil);
    } else {
      if (email == detil.emailid) {
        // getTotalBalance(detil.type, detil.amount);
        return expenseTile(detil.amount, detil.note, detil);
      }
    }
    return Container();
  }

  balance() async{
   await FirebaseFirestore.instance
        .collection('expenses')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["type"] == 'Income' && email == doc["email"]) {
          totalBalance += int.parse( doc["amount"]);
          totalIncome += int.parse( doc["amount"]);
          print("totalBalance :- " + totalBalance.toString());
          print("totalincome :- " + totalIncome.toString());
        } else {
          if (email == doc["email"]) {
            totalBalance -= int.parse( doc["amount"]);
            totalExpense += int.parse( doc["amount"]);
            print("totalBalance :- " + totalBalance.toString());
            print("totalexpense :- " + totalExpense.toString());
          }
        }
      });
    });
   setState(() {

   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      backgroundColor: Color(0xffe2e7ef),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => SelectCategory(email: email),
            ),
          )
              .whenComplete(() {
            setState(() {});
          });
        },
        backgroundColor: Static.PrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16.0,
          ),
        ),
        child: Icon(
          Icons.add,
          size: 32.0,
        ),
      ),
      body: FutureBuilder<Map>(
          future: null,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Unexpected Error!1"),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text("No valuse found!"),
                );
              }
              return ListView(
                //t1
                children: [
                  Text("Tejas"),
                ],
              );
            } else {
              // return Center(
              //   child: Text("Unexpected Error!2"),
              // );

              // below code goes at t1 from return listview
              // getTotalBalance(snapshot.data!);
              // getPlotPoints(snapshot.data!);
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  32.0,
                                ),
                                color: Colors.white70,
                              ),
                              child: CircleAvatar(
                                maxRadius: 32.0,
                                child: Image.asset(
                                  "assets/face.png",
                                  width: 64.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "Track Your Expense Here",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                                color: Static.PrimaryMaterialColor[800],
                              ),
                            ),
                          ],
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                12.0,
                              ),
                              color: Colors.white70,
                            ),
                            padding: EdgeInsets.all(
                              5.0,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.settings,
                              ),
                              iconSize: 30,
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserInformation(email: email),
                                  ),
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.all(
                      12.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Static.PrimaryColor,
                            Colors.blueAccent,
                          ],
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(24.0),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 8.0,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Total Balance',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            // 'Rs $totalBalance',
                            totalBalance.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                              8.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                cardIncome(
                                  totalIncome.toString(),
                                ),
                                cardExpense(
                                  totalExpense.toString(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextButton(
                        child: Text(
                          "See Detailed Summary",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LineBar(email: email),
                            ),
                          );
                        },
                      )),

                  //
                  //chart
                  //below code is in right place . no need to change it.
                  // dataSet.length < 2?
                  //     Container(
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(
                  //             8.0,
                  //           ),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey.withOpacity(0.4),
                  //               spreadRadius: 5,
                  //               blurRadius: 6,
                  //               offset: Offset(0, 4),
                  //             ),
                  //           ],
                  //         ),
                  //         padding: EdgeInsets.symmetric(
                  //           horizontal: 8.0,
                  //           vertical: 40.0,
                  //         ),
                  //         margin: EdgeInsets.all(12.0),
                  //         child: Text(
                  //           "Not enough values to render chart",
                  //           style: TextStyle(
                  //             fontSize: 20.0,
                  //             color: Colors.black87,
                  //           ),
                  //         ),
                  //       )
                  //     :
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
                              ]),
                        ],
                      ),
                    ),
                  ),

                  //
                  // recent expenses
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Recent Expenses",
                        style: TextStyle(
                          fontSize: 32.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      )),

                  //
                  // expenseTile(120, "stationary"),
                  // incomeTile(500, "mobile"),
                  // expenseTile(300, 'food'),
                  // incomeTile(1500, "lottery"),

                  StreamBuilder<List<Details>>(
                      stream: readUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final txdatas = snapshot.data!;

                          return ListView(
                            shrinkWrap: true,
                            children: txdatas.map(buildUser).toList(),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),

                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.lightbulb_circle_rounded,
                            ),
                            iconSize: 40,
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => InvestSuggestion(savbalance:totalBalance),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            "Invest Suggestion",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      )),

                  SizedBox(
                    height: 55,
                  )
                ],
              ); //t1 ends
            }
          }),
    );
  }

  Widget cardIncome(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          padding: EdgeInsets.all(6.0),
          child: Icon(
            Icons.arrow_downward,
            size: 28.0,
            color: Colors.green[700],
          ),
          margin: EdgeInsets.only(
            right: 8.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Income',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget cardExpense(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          padding: EdgeInsets.all(6.0),
          child: Icon(
            Icons.arrow_upward,
            size: 28.0,
            color: Colors.red[700],
          ),
          margin: EdgeInsets.only(
            right: 8.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expense',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget expenseTile(int value, String note, Details detil) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(
        18.0,
      ),
      decoration: BoxDecoration(
        color: Color(
          0xffced4eb,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_circle_up_outlined,
                ),
                iconSize: 28,
                color: Colors.red[700],
                onPressed: () {
                  print(detil.note);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ViewTransaction(tdetail: detil),
                    ),
                  );
                },
              ),
              SizedBox(
                width: 4.0,
              ),
              Text(
                note,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          Text(
            "-$value",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget incomeTile(int value, String note, Details detil) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(
        18.0,
      ),
      decoration: BoxDecoration(
        color: Color(
          0xffced4eb,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_circle_down_outlined,
                ),
                iconSize: 28,
                color: Colors.green[700],
                onPressed: () {
                  print(detil.note);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ViewTransaction(tdetail: detil),
                    ),
                  );
                },
              ),
              SizedBox(
                width: 4.0,
              ),
              Text(
                note,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          Text(
            "$value",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
