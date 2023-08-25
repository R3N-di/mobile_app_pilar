// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/constant/colors.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(),
      elevation: 0,
      title: Text(
        'PT PILAR SOLUSI INDONESIA',
        style: TextStyle(color: black),
        textAlign: TextAlign.right,
        textWidthBasis: TextWidthBasis.longestLine,
      ),
      // centerTitle: true,
      backgroundColor: primaryGreen,
    );
  }
}