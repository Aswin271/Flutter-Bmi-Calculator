// ignore_for_file: prefer_const_constructors, annotate_overrides

import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:flutter_bmi_project/functions.dart';

class BMISignupPage extends StatefulWidget {
  const BMISignupPage({super.key});

  @override
  State<BMISignupPage> createState() => _BMISignupPageState();
}

class _BMISignupPageState extends State<BMISignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  bool obscureText = true;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    // Regular expression for email validation
    String pattern = r'^[^@]+@[^@]+\.[^@]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  void _signUp() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
   
    String username = userNameController.text;
    String password = passwordController.text;
    String confirmPassword = passwordConfirmController.text;

    if (password == confirmPassword) {
      await storeUsername(username);
      await storePassword(password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Sign up successful!"),
      ));
      Navigator.pop(context); // Go back to login page
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Passwords do not match"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          width: 500,
          height: 600,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Title(
                    color: Colors.black,
                    child: Text(
                      "Sign Up!",
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  SizedBox(height: 50),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: "E-Mail",
                      prefixIcon: Icon(
                        Icons.mail,
                        size: 18,
                      ),
                    ),
                    validator: validateEmail,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: "Username",
                      prefixIcon: Icon(
                        Icons.person,
                        size: 18,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: "Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 18,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: passwordConfirmController,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: "Confirm Password",
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 18,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                          size: 18,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 50),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) {
                      setState(() {
                        isHovered = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        isHovered = false;
                      });
                    },
                  child:ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                      foregroundColor:isHovered? Colors.white:Colors.black, backgroundColor:isHovered ? Colors.black:Colors.white24, shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: isHovered?24:16,
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),)
                ],
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}