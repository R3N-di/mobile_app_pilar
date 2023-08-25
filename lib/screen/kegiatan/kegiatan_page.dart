import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/constant/colors.dart';

import '../../widgets/app_header.dart';

class Kegiatan extends StatefulWidget {
  @override
  _KegiatanState createState() => _KegiatanState();
}

class _KegiatanState extends State<Kegiatan> {
  List<KegiatanData> kegiatanList = [
    KegiatanData('Makan siang bersama', '12 Agustus 2023', 'Tim A', 'John Doe'),
    KegiatanData('Rapat tim proyek', '15 Agustus 2023', 'Tim B', 'Jane Smith'),
    KegiatanData(
        'Presentasi mingguan', '17 Agustus 2023', 'Tim C', 'Robert Johnson'),
    // ... tambahkan lebih banyak data kegiatan di sini
  ];

  TextEditingController searchController = TextEditingController();
  List<KegiatanData> filteredKegiatan = [];

  @override
  void initState() {
    filteredKegiatan = kegiatanList; // Mengisi awal daftar kegiatan
    super.initState();
  }

  void _filterKegiatan(String query) {
    setState(() {
      filteredKegiatan = kegiatanList
          .where((kegiatan) =>
              kegiatan.judul.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _clearSearch() {
    searchController.clear();
    _filterKegiatan('');
    // Hapus fokus dari tombol hapus
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(),
      body: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Center(
            child: Text(
              'Kegiatan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterKegiatan,
              decoration: InputDecoration(
                labelText: 'Cari Kegiatan',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: _clearSearch,
                ),
              ),
            ),
          ),
          Container(
            height: 100, // Tinggi yang diinginkan
            child: DataTable(
              columnSpacing: 35, // Jarak antar kolom
              dataRowHeight: 100, // Tinggi baris
              columns: [
                DataColumn(label: Text('Judul')),
                DataColumn(label: Text('Tanggal')),
                DataColumn(label: Text('Tim')),
                DataColumn(label: Text('Pemimpin')),
              ],
              rows: filteredKegiatan
                  .map((kegiatan) => DataRow(cells: [
                        DataCell(Text(kegiatan.judul)),
                        DataCell(Text(kegiatan.tanggal)),
                        DataCell(Text(kegiatan.tim)),
                        DataCell(Text(kegiatan.pemimpin)),
                      ]))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class KegiatanData {
  final String judul;
  final String tanggal;
  final String tim;
  final String pemimpin;

  KegiatanData(this.judul, this.tanggal, this.tim, this.pemimpin);
}

void main() {
  runApp(MaterialApp(home: Kegiatan()));
}
