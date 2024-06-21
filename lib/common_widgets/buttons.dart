import 'package:flutter/material.dart';

class ElevatedButtonClass extends StatelessWidget {
  final Color color;
  final Color bdcolor;

  final Widget text;
  final Function onTap;

  const ElevatedButtonClass({
    Key? key,
    required this.bdcolor,
    required this.color,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.05,
      width: screenWidth * 0.5,
      child: ElevatedButton(
        onPressed: () => onTap(),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(
              color: bdcolor,
            ),
          ),
        ),
        child: text,
      ),
    );
  }
}
