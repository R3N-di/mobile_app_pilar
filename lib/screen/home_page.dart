// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/screen/maintenance/mainhole_page.dart';
import '../widgets/app_header.dart';
import '../widgets/auto_scroll_header.dart';

import 'kegiatan/jadwal_page.dart';
import 'kegiatan/kegiatan_page.dart';
import 'kegiatan/inventaris_page.dart';
import 'kegiatan/user_page.dart';
import 'kegiatan/perangkat_page.dart';

import '../widgets/activity_box/activity_box_list.dart';
import '../widgets/activity_box/activity_title.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> kegiatan = [
    {
      'text': 'Jadwal',
      'icon': Icon(Icons.today),
      'page': JadwalPage()
    },
    {
      'text': 'Kegiatan\nHarian',
      'icon': Icon(Icons.calendar_month),
      'page': Kegiatan()
    },
    {
      'text': 'Inventaris\nPerangkat',
      'icon': Icon(Icons.add_to_home_screen_rounded),
      'page': Inventaris()
    },
    {
      'text': 'Perangkat\nCustomer',
      'icon': Icon(Icons.android),
      'page': Perangkat()
    },
    {
      'text': 'User Teknisi',
      'icon': Icon(Icons.recent_actors),
      'page': UserPage()
    },
  ];

  final List<Map<String, dynamic>> maintenance = [
    {
      'text': 'Mainhole',
      'icon': Icon(Icons.today),
      'page': MainholePage()
    },
    {
      'text': 'Kerusakan\nFO     ',
      'icon': Icon(Icons.calendar_month),
      'page': Kegiatan()
    },
  ];

  final List<Map<String, dynamic>> datavms = [
    {
      'text': 'Lokasi\nVMS',
      'icon': Icon(Icons.today),
      'page': MainholePage()
    },
    {
      'text': 'Spesifikasi\nVMS     ',
      'icon': Icon(Icons.calendar_month),
      'page': Kegiatan()
    },
  ];

  final List<Map<String, dynamic>> lembur = [
    {
      'text': 'Tiket\nLembur',
      'icon': Icon(Icons.today),
      'page': MainholePage()
    },
    {
      'text': 'Approve\nLembur     ',
      'icon': Icon(Icons.calendar_month),
      'page': Kegiatan()
    },
  ];

  final List<Map<String, dynamic>> kasbon = [
    {
      'text': 'Approve\nKasbon',
      'icon': Icon(Icons.today),
      'page': MainholePage()
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AutoScrollHeader(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ActivityTitleRow(
                      text: 'Kegiatan', page: AllKegiatanPage()),
                  SizedBox(height: 16),
                  ActivityBoxList(activities: kegiatan),
                  SizedBox(height: 16),
                  ActivityTitleRow(
                      text: 'Maintenance', page: AllKegiatanPage()),
                  SizedBox(height: 16),
                  ActivityBoxList(activities: maintenance),
                  SizedBox(height: 16),
                  ActivityTitleRow(
                      text: 'Data VMS', page: AllKegiatanPage()),
                  SizedBox(height: 16),
                  ActivityBoxList(activities: datavms),
                  SizedBox(height: 16),
                  ActivityTitleRow(
                      text: 'Lembur', page: AllKegiatanPage()),
                  SizedBox(height: 16),
                  ActivityBoxList(activities: lembur),
                  SizedBox(height: 16),
                  ActivityTitleRow(
                      text: 'Kasbon', page: AllKegiatanPage()),
                  SizedBox(height: 16),
                  ActivityBoxList(activities: kasbon),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllKegiatanPage extends StatelessWidget {
  const AllKegiatanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(),
    );
  }
}
