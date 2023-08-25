import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/constant/colors.dart';

class ActivityBox extends StatelessWidget {
  final String text;
  final Icon icon;
  final double width;
  final Widget page;

  ActivityBox(
      {required this.text, required this.icon, required this.width, required this.page});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: width,
          height: 80,
          color: primaryGreen,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              SizedBox(height: 4,),
              Text(text,
                  style: TextStyle(color: black,fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
