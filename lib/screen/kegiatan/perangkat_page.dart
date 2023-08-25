// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/constant/colors.dart';

import '../../widgets/app_header.dart';

class Perangkat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppHeader(),
        body: Column(
          children: [
            SizedBox(height: 12,),
            Center(
              child: Text(
                'Perangkat Customer',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w500),
              )
            ),
          ],
        ));
  }
}
