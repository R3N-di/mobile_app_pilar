import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/widgets/app_header.dart';
import 'package:mobile_app_pilar/constant/colors.dart';
import 'package:mobile_app_pilar/models/mainhole_model.dart';
import 'package:mobile_app_pilar/services/mainhole_service.dart';

class MainholePage extends StatefulWidget {
  const MainholePage({super.key});

  @override
  _MainholePageState createState() => _MainholePageState();
}

class _MainholePageState extends State<MainholePage> {
  @override
  void initState() {
    data = MainholeService().getMainhole();
    data.then((value) {
      setState(() {
        data2 = value;
      });
    });
    super.initState();
  }

  late Future data;
  List<MainholeModel> data2 = [];

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
                    title: Text(data2[index].lokasi),
                  );
                },
              ));
  }
}
