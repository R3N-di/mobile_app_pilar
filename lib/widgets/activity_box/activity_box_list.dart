import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/widgets/activity_box/activity_box.dart';

class ActivityBoxList extends StatelessWidget {
  final List<Map<String, dynamic>> activities;

  ActivityBoxList({required this.activities});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: activities
            .map((activity) => Row(
                  children: [
                    ActivityBox(
                      text: activity['text'],
                      icon: activity['icon'],
                      width: activity['text'].length < 16 ? 70 : 100,
                      page: activity['page'],
                    ),
                    SizedBox(width: 16),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
