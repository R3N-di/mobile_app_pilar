// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/constant/colors.dart';
import 'package:mobile_app_pilar/models/mainhole.model.dart';
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
    print(data2);
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
        floatingActionButton: FloatingActionButton(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 50,
              height: 50,
              color: black,
              child: Icon(Icons.arrow_back_ios_new_rounded,
                  color: textWhite),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          elevation: 10,
          foregroundColor: Colors.transparent,
          backgroundColor: black,
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.startTop,
        floatingActionButtonAnimator:
            FloatingActionButtonAnimator.scaling,
        body: data2.length == 0
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : MyDataTableWidget());
  }
}

class MyDataTableWidget extends StatefulWidget {
  @override
  _MyDataTableWidgetState createState() => _MyDataTableWidgetState();
}

class _MyDataTableWidgetState extends State<MyDataTableWidget> {
  late Future dataService;
  List<dynamic> dataMainhole = [];
  List<DataRow> _dataRows = [];

  List<DataRow> _filteredRows = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    dataService = MainholeService().getMainhole();
    dataService.then((value) {
      setState(() {
        dataMainhole = value;
        print(["Data Mainhole", dataMainhole]);
        final List<DataRow> newDataRows = dataMainhole.map((data) {
          return DataRow(cells: [
            DataCell(Text(data.lokasi)),
            DataCell(Text(data.posisi.toString())),
            DataCell(Text(data.bulan)),
          ]);
        }).toList();
        _dataRows = newDataRows;
        _filteredRows = _dataRows;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          DataTable(
            columns: [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Age')),
              DataColumn(
                  label: Text('Location')), // New column for actions
            ],
            rows: _filteredRows.map((row) {
              return DataRow(
                cells: [
                  ...row.cells,
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
