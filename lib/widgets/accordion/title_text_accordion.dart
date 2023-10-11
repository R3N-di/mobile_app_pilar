import 'package:flutter/material.dart';


class TitleTextWidget extends StatelessWidget {
  final List<String> texts;
  final List<TextStyle> textStyles; // Gaya teks untuk setiap teks

  TitleTextWidget({required this.texts, required this.textStyles});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(texts.length, (index) {
        final textStyle = textStyles[index] ;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Text(
            texts[index],
            style: textStyle,
          ),
        );
      }),
    );
  }
}