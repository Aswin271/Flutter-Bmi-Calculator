// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    appBar: AppBar(backgroundColor: Colors.white,title: Center(child: Text("BMI Info",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w900,color: Colors.black),)),),
    body: Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Body Mass Index (BMI) is a person's weight in kilograms divided by the square of height in meters. A high BMI can indicate high body fatness. BMI screens for weight categories that may lead to health problems, but it does not diagnose the body fatness or health of an individual.",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15.0),),
      ),
      Image.network("https://thumbs.dreamstime.com/b/body-mass-index-vector-illustration-underweight-to-extremely-obese-woman-silhouettes-different-obesity-degrees-female-97102039.jpg?w=360"),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("How Do I Interpret Body Mass Index Information?",style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.w900),),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("The BMI is expressed in kg/m2, resulting from mass in kilograms and height in metres. If pounds and inches are used, a conversion factor of 703 (kg/m2)/(lb/in2) is applied. (If pounds and feet are used, a conversion factor of 4.88 is used.) When the term BMI is used informally, the units are usually omitted.",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w900),),
      ),
      Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnSvhjl37mRNTd-YA73rIb9Iq9ZpK_Yu_b9A&s",width: 62.0,height: 62.0,)
      
    ],),);
  }
}