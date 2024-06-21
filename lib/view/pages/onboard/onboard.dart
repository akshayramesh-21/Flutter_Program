import 'package:flutter/material.dart';
import 'package:geeksynergy/common_widgets/buttons.dart';
import 'package:geeksynergy/controller/utlities/utlitis.dart';
import 'package:geeksynergy/view/pages/login/login.dart';
import 'package:geeksynergy/view/pages/signup/singup.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              appColor.withOpacity(0.1),
              appColor
            ], 
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(children: [
          SizedBox(height: screenHeight * 0.1),
          Center(
              child: Image.asset('assets/images/question-mark.png',
                  width: screenHeight * 0.2)),
          SizedBox(height: screenHeight * 0.05),
          Center(
              child: Text(
            "Hello !",
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          )),
          SizedBox(height: screenHeight * 0.05),
          Center(
              child: Text(
            "Welcome to ",
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
          Center(
              child: Text(
            "Flutter Program!",
            style: TextStyle(fontSize: 25, color: Colors.white),
          )),
          SizedBox(height: screenHeight * 0.1),
          Center(
              child: ElevatedButtonClass(
            bdcolor: Colors.white,
            color: appColor,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            text: Text(
              "Login",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "akrobat",
                  fontSize: 14),
            ),
          )),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Center(
              child: ElevatedButtonClass(
            bdcolor: appColor,
            color: Colors.white,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignupPage()));
            },
            text: Text(
              "Sign Up",
              style: TextStyle(
                  color: appColor.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                  fontFamily: "akrobat",
                  fontSize: 14),
            ),
          )),
        ]),
      ),
    );
  }
}
