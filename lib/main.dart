import 'package:flutter/material.dart';
import 'package:tpcities/child/childHome.dart';
import 'package:tpcities/home.dart';
import 'package:tpcities/parent/parentHome.dart';
import 'package:tpcities/screens/childorparent.dart';
import 'package:tpcities/screens/userpage.dart';
import 'package:tpcities/service/login.dart';
import 'package:tpcities/service/signin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(


        primarySwatch: Colors.blue,
      ),

      routes: {
        '/':(context) =>choose(),
        '/login':(context)=>FormValidation(),
        '/city':(context)=>Home(),
        '/signin':(context)=>Signin(),
        '/choose':(context) =>choose(),
        '/parentHome':(contex)=> ParentHome(),
        '/childHome':(contex)=> ChildHome()
      },
    );
  }
}

