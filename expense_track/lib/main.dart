import 'package:expense_track/Screens/LoginForm.dart';
import 'package:expense_track/pages/homepage.dart';
import 'package:expense_track/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     Firebase.initializeApp();
    return MaterialApp(
      title: 'Money Manager',
      theme: myTheme,
      home: LoginPage(),
    );
  }
}
