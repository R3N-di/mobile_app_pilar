import 'package:flutter/material.dart';


class TextFieldWidget extends StatelessWidget {
  Text textTitle;
  Text textSubtitle;
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
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(4))),
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