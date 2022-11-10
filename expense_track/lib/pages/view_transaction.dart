import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_track/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:expense_track/static.dart' as Static;
import 'package:flutter/services.dart';
import 'details.dart';

class ViewTransaction extends StatefulWidget {
  final Details tdetail;
  ViewTransaction({ Key? key, required this.tdetail}) : super(key: key);

  @override
  State<ViewTransaction> createState() => _ViewTransactionState(tdetail);
}

class _ViewTransactionState extends State<ViewTransaction> {
  int amount = 500;
  String note = 'nt';
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
Details tdetail;
  _ViewTransactionState(this.tdetail);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        backgroundColor: Color(0xffe2e7ef),
        body: ListView(
          padding: EdgeInsets.all(
            12.0,
          ),
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              "View Expense Detail",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Static.PrimaryColor,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.all(
                    12.0,
                  ),
                  child: Icon(
                    Icons.category,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Text(
                  tdetail.category,
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Static.PrimaryColor,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.all(
                    12.0,
                  ),
                  child: Icon(
                    Icons.attach_money,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: Text(
                    tdetail.amount.toString(),
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Static.PrimaryColor,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.all(
                    12.0,
                  ),
                  child: Icon(
                    Icons.description,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: Text(
                    tdetail.note,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Static.PrimaryColor,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.all(
                    12.0,
                  ),
                  child: Icon(
                    Icons.moving_sharp,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Text(
                  tdetail.type,
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  width: 12.0,
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 50.0,
              child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.zero,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Static.PrimaryColor,
                          borderRadius: BorderRadius.circular(
                            16.0,
                          ),
                        ),
                        padding: EdgeInsets.all(
                          12.0,
                        ),
                        child: Icon(
                          Icons.date_range,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        tdetail.selectedDate.toString(),
                        //"${tr.selectedDate.day} ${months[tr.selectedDate.month - 1]}",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {
                  if (amount != null && note.isNotEmpty) {
                    print("delete");

                    FirebaseFirestore.instance.collection("expenses").doc(tdetail.id).delete();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          email: tdetail.emailid,
                        ),
                      ),
                    );
                  } else {
                    print("Something is wrong!!");
                  }
                },
                child: Text(
                  "Delete ",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
