// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings, depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  Text textTitle;
  dynamic textSubtitle;
  Color color;

  TextFieldWidget({
    super.key,
    required this.textTitle,
    required this.textSubtitle,
    this.color = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: textTitle),
          SizedBox(
            width: 16,
          ),
          Expanded(child: textSubtitle),
        ],
      ),
    );
  }
}
