import 'package:flutter/material.dart';

class ActivityTitleRow extends StatelessWidget {
  final String text;
  final dynamic page;

  ActivityTitleRow({
    required this.text, required this.page
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => page),
                    );
          },
          child: Text(
            'Semua >',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
