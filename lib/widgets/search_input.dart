import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/constant/colors.dart';

class SearchInput extends StatelessWidget {
  void Function(String) onChanged;
  void Function() clearSearch;
  TextEditingController controller;

  SearchInput(
      {super.key, required this.onChanged, required this.controller, required this.clearSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: primaryGreen,
      ),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search...',
          fillColor: primaryGreen,
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: clearSearch,
          ),
        ),
      ),
    );
  }
}
