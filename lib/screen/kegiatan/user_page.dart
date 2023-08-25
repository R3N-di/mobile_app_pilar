import 'package:flutter/material.dart';

import 'package:mobile_app_pilar/models/user_model.dart';
import 'package:mobile_app_pilar/services/user_service.dart'; // Import the dart:io library

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    data = UserService().getUser();
    data.then((value) {
      setState(() {
        data2 = value;
      });
    });
    super.initState();
  }

  late Future data;
  List<UserModel> data2 = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User Page'),
        ),
        body: data2.length == 0
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : ListView.builder(
                itemCount: data2.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data2[index].userNama),
                  );
                },
              ));
  }
}
