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
  List<LokasiVmsData> lokasiVmsList = [];

  TextEditingController searchController = TextEditingController();
  List<LokasiVmsData> filteredLokasiVms = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    List<LokasiVmsModel> data2 = await LokasiVmsService().getLokasiVms();
    setState(() {
      lokasiVmsList = data2
          .map((item) =>
              LokasiVmsData(item.namaLokasiVms, item.lajurLokasiVms.toString(), item.koordinatLokasiVms))
          .toList();
      filteredLokasiVms = lokasiVmsList; // Mengisi filteredLokasiVms dengan semua data awal
    });
  }

  void _filterLokasiVms(String query) {
    setState(() {
      filteredLokasiVms = lokasiVmsList
          .where((lokasiVms) =>
              lokasiVms.nama_lokasi_vms.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _clearSearch() {
    searchController.clear();
    if (searchController.text.isEmpty) {
      setState(() {
        filteredLokasiVms = lokasiVmsList;
      });
    }
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
              child: DataTable(
                columnSpacing: 35,
                columns: [
                  DataColumn(label: Text('NAMA LOKASI')),
                  DataColumn(label: Text('LAJUR LOKASI')),
                  DataColumn(label: Text('KOORDINAT LOKASI')),
                ],
                rows: filteredLokasiVms
                    .map((lokasiVms) => DataRow(cells: [
                          DataCell(Text(lokasiVms.nama_lokasi_vms)),
                          DataCell(Text(lokasiVms.lokasi_vms)),
                          DataCell(Text(lokasiVms.koordinat_lokasi_vms)),
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
