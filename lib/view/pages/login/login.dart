import 'package:flutter/material.dart';
import 'package:geeksynergy/controller/utlities/utlitis.dart';
import 'package:geeksynergy/view/pages/homePage/homepage.dart';
import 'package:geeksynergy/view/pages/signup/singup.dart';
import 'package:hive/hive.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _nameError;
  String? _passwordError;

  void _login() async {
    setState(() {
      _nameError = null;
      _passwordError = null;
    });

    if (_formKey.currentState!.validate()) {
      var box = Hive.box('userBox');
      String? storedName = box.get('name');
      String? storedPassword = box.get('password');

      if (storedName == _nameController.text &&
          storedPassword == _passwordController.text) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Center(child: Text('Invalid Credentials'))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: screenHeight * 0.18),
              Center(child: Text("Login", style: style2)),
              SizedBox(height: screenHeight * 0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 16, top: 16, bottom: 16),
                        isDense: true,
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorStyle: TextStyle(height: 0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            _nameError = 'Please enter your name';
                          });
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                  if (_nameError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        _nameError!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 16, top: 16, bottom: 16),
                        isDense: true,
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorStyle: TextStyle(height: 0),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            _passwordError = 'Please enter your password';
                          });
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                  if (_passwordError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        _passwordError!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _login,
                child: Container(
                  width: screenWidth * 0.2,
                  height: screenHeight * 0.05,
                  decoration: BoxDecoration(
                    color: appColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text("Login", style: style1),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No account? "),
                      Text(
                        "SignUp",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
