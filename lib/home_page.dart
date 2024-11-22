// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bmi_project/functions.dart';
import 'package:flutter_bmi_project/info.dart';
import 'package:flutter_bmi_project/login_page.dart';
import 'package:flutter_bmi_project/models/store_details.dart';
import 'package:flutter_bmi_project/results_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<StoreDetails> storeDetailsList = [];

  String? gender;
  TextEditingController weightControl = TextEditingController();
  TextEditingController heightControl = TextEditingController();
  TextEditingController nameControl = TextEditingController();
  TextEditingController ageControl = TextEditingController();
  var result = "";

  void _calculateBMI() async {
    String weightStr = weightControl.text;
    String heightStr = heightControl.text;
    String nameStr = nameControl.text;
    String ageStr = ageControl.text;

    if (weightStr.isEmpty || heightStr.isEmpty || nameStr.isEmpty || ageStr.isEmpty) {
      final snackBar = SnackBar(
        content: Text("Please fill in all fields."),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    double weight = double.parse(weightStr);
    double height = double.parse(heightStr) / 100; // Convert cm to meters

    if (height == 0) {
      final snackBar = SnackBar(
        content: Text("Height cannot be zero."),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    double bmi = weight / (height * height);
    String resultMessage = "Your BMI is ${bmi.toStringAsFixed(2)}.\n";
    String condition;

    if (bmi < 18.5) {
      condition = "Underweight";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      condition = "Healthy";
    } else if (bmi >= 25 && bmi < 29.9) {
      condition = "Overweight";
    } else {
      condition = "Obese";
    }

    resultMessage += "Condition: $condition";

    // Store details in the list
    StoreDetails details = StoreDetails(
    nameStr,
    int.parse(ageStr),
    int.parse(heightStr),
    int.parse(weightStr),
    bmi,
  );

    setState(() {
      storeDetailsList.add(details);
    });

    // Save to shared preferences
    await storeDetails(storeDetailsList);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("BMI Result"),
          content: Text(resultMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
        backgroundColor: Colors.cyanAccent[400],
        title: Text(
          "BMI CALCULATOR",
          style: TextStyle(color: Color.fromARGB(255, 243, 241, 241)),
        ),
        leading: Image.asset('assets/bmi_test.png', height: 50, width: 50),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
              tooltip: 'Menu',
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.cyanAccent[400],
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Info()));
              },
            ),
            ListTile(
              leading: Icon(Icons.format_list_numbered),
              title: Text('Results'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ResultsView()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                storeBool(false);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 400,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Adjusts to the minimum height
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Let's Calculate Your BMI",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: nameControl,
                    decoration: InputDecoration(
                      labelText: "Enter your name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter,
                    ],
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: ageControl,
                    decoration: InputDecoration(
                      labelText: "Enter your Age",
                      prefixIcon: Icon(Icons.calendar_month),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: 8),
                      Text(
                        "Select your Gender",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: 'male',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                      Text('Male'),
                      Radio<String>(
                        value: 'female',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                      Text('Female'),
                    ],
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: weightControl,
                    decoration: InputDecoration(
                      labelText: "Enter your weight (in kgs)",
                      prefixIcon: Icon(Icons.line_weight),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: heightControl,
                    decoration: InputDecoration(
                      labelText: "Enter your height (in cms)",
                      prefixIcon: Icon(Icons.height),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _calculateBMI,
                    child: Text(
                      "Calculate",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
