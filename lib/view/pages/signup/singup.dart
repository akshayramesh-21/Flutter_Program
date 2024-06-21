import 'package:flutter/material.dart';
import 'package:geeksynergy/controller/utlities/utlitis.dart';
import 'package:geeksynergy/view/pages/login/login.dart';
import 'package:geeksynergy/view/pages/signup/commonWidget/textfield.dart';
import 'package:hive/hive.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final ValueNotifier<String?> _selectedProfessionNotifier =
      ValueNotifier<String?>(null);
  final List<String> _professions = [
    'Driver',
    'Software developer',
    'Farmer',
    'Engineer'
  ];

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      var box = Hive.box('userBox');

      box.put('name', _nameController.text);
      box.put('password', _passwordController.text);
      box.put('email', _emailController.text);
      box.put('phone', _phoneController.text);
      box.put('profession', _selectedProfessionNotifier.value);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data saved successfully!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
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
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Center(
                  child: Text(
                "SignUp",
                style: style2,
              )),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              CustomTextField(
                controller: _nameController,
                labelText: 'Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _passwordController,
                labelText: 'Password',
                isObscure: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _emailController,
                labelText: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _phoneController,
                labelText: 'Phone Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              ValueListenableBuilder<String?>(
                valueListenable: _selectedProfessionNotifier,
                builder: (context, value, child) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButtonFormField<String>(
                      value: value,
                      hint: Text('Select Profession'),
                      onChanged: (newValue) {
                        _selectedProfessionNotifier.value = newValue;
                      },
                      items: _professions.map((profession) {
                        return DropdownMenuItem(
                          value: profession,
                          child: Text(profession),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your profession';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              GestureDetector(
                onTap: _saveData,
                child: Container(
                  width: screenWidth * 0.2,
                  height: screenHeight * 0.06,
                  decoration: BoxDecoration(
                      color: appColor, borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text(
                    "Create account",
                    style: style1,
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have account? "),
                      Text(
                        "SignIn",
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
