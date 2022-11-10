import 'package:expense_track/pages/add_transaction.dart';
import 'package:flutter/material.dart';

class SelectCategory extends StatelessWidget {
  String email;

   SelectCategory({Key? key,  required this.email}) : super(key: key);
  final mycontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Category"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Icon(
                          Icons.fastfood,
                          size: 70
                      ),
                      ElevatedButton(
                        onPressed: ()=>{
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTransaction(text: 'Food',email:email),
                            ),
                          )
                        },
                        child: Text('Food'),
                      ),
                    ]),
                    Column(children: <Widget>[
                      Icon(
                          Icons.medical_information,
                          size: 70
                      ),
                      ElevatedButton(
                        onPressed: ()=>{
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTransaction(text : "Medical",email:email),
                            ),
                          )
                        },
                        child: Text('Medical'),
                      ),
                    ]),
                    Column(children: <Widget>[
                      Icon(
                          Icons.library_books,
                          size: 70
                      ),
                      ElevatedButton(
                        onPressed: ()=>{
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTransaction(text : "Education",email:email),
                            ),
                          )
                        },
                        child: Text('Education'),
                      ),
                    ]),
                  ]
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Icon(
                          Icons.payment,
                          size: 70
                      ),
                      ElevatedButton(
                        onPressed: ()=>{
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTransaction(text : "Bills",email:email),
                            ),
                          )
                        },
                        child: Text('Bills'),
                      ),
                    ]),
                    Column(children: <Widget>[
                      Icon(
                          Icons.car_rental,
                          size: 70
                      ),
                      ElevatedButton(
                        onPressed: ()=>{
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTransaction(text : "Travel",email:email),
                            ),
                          )
                        },
                        child: Text('Travel'),
                      ),
                    ]),
                    Column(children: <Widget>[
                      Icon(
                          Icons.shopping_cart,
                          size: 70
                      ),
                      ElevatedButton(
                        onPressed: ()=>{
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTransaction(text : "General",email:email),
                            ),
                          )
                        },
                        child: Text('General'),
                      ),
                    ]),
                  ]
              ),
            ],
          ),
        ));
  }
}
