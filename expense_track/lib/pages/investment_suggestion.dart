import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';

class InvestSuggestion extends StatefulWidget {
  int savbalance;
  InvestSuggestion({Key? key, required this.savbalance}) : super(key: key);

  @override
  State<InvestSuggestion> createState() => _InvestSuggestionState(savbalance);
}


class _InvestSuggestionState extends State<InvestSuggestion> {
  int savbalance;
  _InvestSuggestionState(this.savbalance);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Total Savings :- ${savbalance}"),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            if( savbalance>=0)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FittedBox(
                  child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Color(0x802196F3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: myDetailsContainer1(),
                            ),
                          ),
                          Container(
                            width: 250,
                            height: 200,
                            margin: new EdgeInsets.symmetric(horizontal: 20.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24.0),
                              child: Image.asset("assets/images/health.jpeg"),
                            ),
                          ),
                        ],
                      )),
                ),
              ),

            if( savbalance>=20000)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FittedBox(
                  child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Color(0x802196F3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: myDetailsContainer4(),
                            ),
                          ),
                          Container(
                            width: 250,
                            height: 180,
                            margin: new EdgeInsets.symmetric(horizontal: 70.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24.0),
                              child: Image.asset("assets/images/gold.jpg"),
                            ),
                          ),
                        ],
                      )),
                ),
              ),

            if( savbalance>=10000 )
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: FittedBox(
                  child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Color(0x802196F3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: myDetailsContainer3(),
                            ),
                          ),
                          Container(
                            width: 250,
                            height: 250,
                            margin: new EdgeInsets.symmetric(horizontal: 30.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset("assets/images/fd.jpeg"),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),

            if( savbalance>=3000 )
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: myDetailsContainer2(),
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 200,
                          margin: new EdgeInsets.symmetric(horizontal: 30.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24.0),
                            child: Image.asset("assets/images/stock.jpeg"),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ));
  }

  Widget myDetailsContainer1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Health Insurance",
            style: TextStyle(
                color: Color(0xffe6020a),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          "Invest in your health.",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget myDetailsContainer2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Stock Market",
            style: TextStyle(
                color: Color(0xffe6020a),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          "Invest in quality stocks",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }

  Widget myDetailsContainer3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Bank account",
            style: TextStyle(
                color: Color(0xffe6020a),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          "Put your money in savings account.",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }

  Widget myDetailsContainer4() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Gold",
            style: TextStyle(
                color: Color(0xffe6020a),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          "Invest in gold.",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }
}
