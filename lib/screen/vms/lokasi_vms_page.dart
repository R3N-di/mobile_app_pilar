import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/models/lokasi_vms_model.dart';
import 'package:mobile_app_pilar/widgets/app_header.dart';
import 'package:mobile_app_pilar/constant/colors.dart';
import 'package:mobile_app_pilar/models/mainhole.model.dart';
import 'package:mobile_app_pilar/services/lokasi_vms_service.dart';

class LokasiVMSPage extends StatefulWidget {
  const LokasiVMSPage({super.key});

  @override
  _LokasiVmsPageState createState() => _LokasiVmsPageState();
}

class _LokasiVmsPageState extends State<LokasiVMSPage> {
  @override
  void initState() {
    data = LokasiVmsService().getLokasiVms();
    data.then((value) {
      setState(() {
        data2 = value;
      });
    });
    super.initState();
  }

  late Future data;
  List<LokasiVmsModel> data2 = [];

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
                    title: Text(data2[index].namaLokasiVms),
                  );
                },
              ));
  }
}
