import 'package:flutter/material.dart';
import 'admin_scaffold.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pilar Solusi Indonesia'),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: '/',
            icon: Icons.av_timer,
          ),
          AdminMenuItem(
            title: 'Kegiatan',
            icon: Icons.android,
            children: [
              AdminMenuItem(
                title: 'Jadwal',
                route: '/secondLevelItem1',
                icon: Icons.circle_outlined,
              ),
              AdminMenuItem(
                title: 'Kegiatan Harian',
                route: '/secondLevelItem2',
                icon: Icons.circle_outlined,
              ),
              AdminMenuItem(
                title: 'Inventaris Perangkat',
                route: '/secondLevelItem2',
                icon: Icons.circle_outlined,
              ),
              AdminMenuItem(
                title: 'Data User Teknisi',
                route: '/secondLevelItem2',
                icon: Icons.circle_outlined,
              ),
              AdminMenuItem(
                title: 'Data Perangkat Customer',
                route: '/secondLevelItem2',
                icon: Icons.circle_outlined,
              ),
            ],
          ),
          AdminMenuItem(
            title: 'Maintenance',
            icon: Icons.quick_contacts_mail_rounded,
            children: [
              AdminMenuItem(
                title: 'Data Mainhole',
                route: '/secondLevelItem1',
                icon: Icons.circle_outlined,
              ),
              AdminMenuItem(
                title: 'Data Kerusakan FO',
                route: '/secondLevelItem2',
                icon: Icons.circle_outlined,
              ),
            ],
          ),
          AdminMenuItem(
            title: 'Data VMS',
            icon: Icons.quick_contacts_mail_rounded,
            children: [
              AdminMenuItem(
                title: 'Lokasi VMS',
                route: '/secondLevelItem1',
                icon: Icons.circle_outlined,
              ),
              AdminMenuItem(
                title: 'Spesifikasi VMS',
                route: '/secondLevelItem2',
                icon: Icons.circle_outlined,
              ),
            ],
          ),
          AdminMenuItem(
            title: 'Lembur',
            icon: Icons.nightlight_round_rounded,
            children: [
              AdminMenuItem(
                title: 'Tiket Lembur',
                route: '/secondLevelItem1',
                icon: Icons.circle_outlined,
              ),
              AdminMenuItem(
                title: 'Approve Lembur',
                route: '/secondLevelItem2',
                icon: Icons.circle_outlined,
              ),
            ],
          ),
          AdminMenuItem(
            title: 'Kasbon',
            icon: Icons.calendar_view_day_outlined,
            children: [
              AdminMenuItem(
                title: 'Approve Kasbon',
                route: '/secondLevelItem1',
                icon: Icons.circle_outlined,
              ),
            ],
          ),
        ],
        selectedRoute: '/',
        onSelected: (item) {
          if (item.route != null) {
            Navigator.of(context).pushNamed(item.route!);
          }
        },
        header: Container(
          height: 68,
          width: double.infinity,
          color: Color(0xff444444),
          child: ListTile(
            leading: Image.asset("assets/images/System/17078_WhatsApp Image 2023-07-05 at 21.24.23.png"),
            title: Text("Admin", style: TextStyle(color: Colors.white),),
            subtitle: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green
                  ),
                ),
                SizedBox(width: 4), // Jarak antara lingkaran online dan text
                Text("Online", style: TextStyle(color: Colors.white),)
              ],
            ),
          ), 
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Pilar Solusi Indonesia',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Dashboard',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        ),
      ),
    ),
    );
  }
}