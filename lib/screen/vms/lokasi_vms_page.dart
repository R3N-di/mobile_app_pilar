import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/constant/colors.dart';
import 'package:mobile_app_pilar/services/lokasi_vms_service.dart';
import 'package:mobile_app_pilar/models/lokasi_vms_model.dart';

import '../../widgets/app_header.dart';

class LokasiVmsPage extends StatefulWidget {
  @override
  _LokasiVmsState createState() => _LokasiVmsState();
}

class _LokasiVmsState extends State<LokasiVmsPage> {
  List<LokasiVmsData> LokasiVmsList = []; // Menggunakan list kosong sebagai awalan

  TextEditingController searchController = TextEditingController();
  List<LokasiVmsData> filteredLokasiVms = [];

  @override
  void initState() {
    super.initState();
    data = LokasiVmsService().getLokasiVms();
    data.then((value) {
      setState(() {
        data2 = value;
        LokasiVmsList = data2
            .map((item) =>
                LokasiVmsData(item.namaLokasiVms, item.lajurLokasiVms.toString(), item.koordinatLokasiVms))
            .toList();
      });
    });
  }

  late Future data;
  List<LokasiVmsModel> data2 = [];

  void _filterLokasiVms(String query) {
    setState(() {
      filteredLokasiVms = LokasiVmsList
          .where((LokasiVms) =>
              LokasiVms.nama_lokasi_vms.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _clearSearch() {
    searchController.clear();
    _filterLokasiVms('');
    // Hapus fokus dari tombol hapus
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            Center(
              child: Text(
                'LokasiVms',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: _filterLokasiVms,
                decoration: InputDecoration(
                  labelText: 'Cari LokasiVms',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: _clearSearch,
                  ),
                ),
              ),
            ),
            Container(
              // height: 100, // Tinggi yang diinginkan
              child: DataTable(
                columnSpacing: 35, // Jarak antar kolom
                // dataRowHeight: 100, // Tinggi baris
                columns: [
                  DataColumn(label: Text('NAMA LOKASI')),
                  DataColumn(label: Text('LAJUR LOKASI')),
                  DataColumn(label: Text('KOORDINAT LOKASI')),
                ],
                rows: filteredLokasiVms
                    .map((LokasiVms) => DataRow(cells: [
                          DataCell(Text(LokasiVms.nama_lokasi_vms)),
                          DataCell(Text(LokasiVms.lokasi_vms)),
                          DataCell(Text(LokasiVms.koordinat_lokasi_vms)),
                        ]))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LokasiVmsData {
  final String nama_lokasi_vms;
  final String lokasi_vms;
  final String koordinat_lokasi_vms;

  LokasiVmsData(this.nama_lokasi_vms, this.lokasi_vms, this.koordinat_lokasi_vms);
}

void main() {
  runApp(MaterialApp(home: LokasiVmsPage()));
}
