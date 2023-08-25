import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/models/spesifikasi_vms_model.dart';
import 'package:mobile_app_pilar/widgets/app_header.dart';
import 'package:mobile_app_pilar/constant/colors.dart';
import 'package:mobile_app_pilar/models/mainhole.model.dart';
import 'package:mobile_app_pilar/services/spesifikasi_vms_service.dart';

class VMSPage extends StatefulWidget {
  const VMSPage({super.key});

  @override
  _VmsPageState createState() => _VmsPageState();
}

class _VmsPageState extends State<VMSPage> {
  @override
  void initState() {
    data = VmsService().getVms();
    data.then((value) {
      setState(() {
        data2 = value;
      });
    });
    super.initState();
  }

  late Future data;
  List<VmsModel> data2 = [];

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
                    title: Text(data2[index].panelVms),
                  );
                },
              ));
  }
}
