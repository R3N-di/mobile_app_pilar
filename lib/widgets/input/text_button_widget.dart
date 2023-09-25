// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings, depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  Widget icon;
  Widget text;
  ButtonStyle style;
  void Function() onPressed;

  TextButtonWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.style,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: style,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            text,
          ],
        ));
  }
}
