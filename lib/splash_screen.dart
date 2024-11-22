// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bmi_project/functions.dart';
import 'package:flutter_bmi_project/home_page.dart';
import 'package:flutter_bmi_project/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    screenDelay();
    super.initState();
  }

  void screenDelay() async {
    await Future.delayed(Duration(seconds: 4));
    bool? isLogged = await retrieveBool();
    if (isLogged == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/bmi_test.png",
              width: 200,
              height: 200,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Eat right to fight fat",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          )
        ],
      ),
    );
  }
}
