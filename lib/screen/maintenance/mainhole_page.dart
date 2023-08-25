import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/widgets/app_header.dart';
import 'package:mobile_app_pilar/constant/colors.dart';
import 'package:mobile_app_pilar/models/mainhole.model.dart';
import 'package:mobile_app_pilar/services/mainhole_service.dart';

class MainholePage extends StatefulWidget {
  const MainholePage({super.key});

  @override
  _MainholeDataTableState createState() => _MainholeDataTableState();
}

class _MainholeDataTableState extends State<MainholePage> {
  late Future<List<MainholeModel>> _mainholeData;

  @override
  void initState() {
    _mainholeData = MainholeService().getMainhole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MainholeModel>>(
      future: _mainholeData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: primaryGreen,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final mainholeData = snapshot.data ?? [];
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyDataTableWidget(mainholeData: mainholeData),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class MyDataTableWidget extends StatefulWidget {
  final List<MainholeModel> mainholeData;

  const MyDataTableWidget({required this.mainholeData, super.key});

  @override
  _MyDataTableWidgetState createState() => _MyDataTableWidgetState();
}

class _MyDataTableWidgetState extends State<MyDataTableWidget> {
  final List<DataRow> _dataRows = [];
  List<DataRow> _filteredRows = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    _dataRows.addAll(widget.mainholeData.map((data) {
      return DataRow(cells: [
        DataCell(Text(data.lokasi)),
        DataCell(Text(data.posisi.toString())),
        DataCell(Text(data.bulan)),
      ]);
    }));
    _filteredRows = _dataRows;
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
              DataColumn(label: Text('Location')),
              DataColumn(label: Text('Actions')), // New column for actions
            ],
            rows: _filteredRows.map((row) {
              return DataRow(
                cells: [
                  ...row.cells,
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => {}, // Call remove function
                  )),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
  
}
