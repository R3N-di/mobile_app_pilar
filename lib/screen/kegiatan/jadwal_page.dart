// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/constant/colors.dart';

import '../../widgets/app_header.dart';

class Jadwal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(),
      floatingActionButton: FloatingActionButton(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 50,
            height: 50,
            color: black,
            child: Icon(Icons.arrow_back_ios_new_rounded,
                color: textWhite),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        elevation: 10,
        foregroundColor: Colors.transparent,
        backgroundColor: black,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.startTop,
      floatingActionButtonAnimator:
          FloatingActionButtonAnimator.scaling,
      body: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Center(
              child: Text(
            'Jadwal',
            style:
                TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          )),
          
        ],
      ), 
    );
  }
}
