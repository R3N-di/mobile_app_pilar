// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/constant/colors.dart';
import 'package:mobile_app_pilar/models/jadwal_model.dart';
import 'package:mobile_app_pilar/services/jadwal_service.dart';

import '../../widgets/app_header.dart';

class JadwalPage extends StatefulWidget {
  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  late Future data;
  TextEditingController searchController = TextEditingController();
  List<dynamic> dataJadwal = [];
  List<DataRow> filteredJadwal = [];
  List<DataRow> barisJadwal = [];

  void _filterJadwal(String query) {
    setState(() {
      filteredJadwal = barisJadwal
          .where((jadwal) => jadwal.cells[0].child
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  void _clearSearch() {
    searchController.clear();
    _filterJadwal('');
    // Hapus fokus dari tombol hapus
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void initState() {
    // TODO: implement initState
    data = JadwalService().getData();
    data.then((value) {
      setState(() {
        dataJadwal = value;
        final List<DataRow> newDataRows = dataJadwal.map((data) {
          return DataRow(cells: [
            DataCell(Text(
              data.namaJadwal,
              style: TextStyle(fontSize: 12),
            )),
            DataCell(Text(data.namaPelanggan)),
            // DataCell(Text(data.statusJadwal)),
            // DataCell(Text(data.tglMulai.toString())),
            // DataCell(Text(data.tglSelesai.toString())),
          ]);
        }).toList();
        filteredJadwal = newDataRows;
        barisJadwal = newDataRows;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            Center(
                child: Text(
              'Jadwal',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w500),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: _filterJadwal,
                decoration: InputDecoration(
                  labelText: 'Cari Jadwal',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: _clearSearch,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                  columnSpacing: 8,
                  dataRowHeight: 30,
                  columns: [
                    DataColumn(label: Text('Nama Jadwal')),
                    DataColumn(label: Text('Nama Pelanggan')),
                    // DataColumn(label: Text('Status Jadwal')),
                    // Add more DataColumn widgets here if needed
                  ],
                  rows: filteredJadwal.map((row) {
                    return DataRow(
                      cells: [
                        ...row.cells,
                        // Add more DataCell widgets here if needed
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
