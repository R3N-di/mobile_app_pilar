import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/screen/home_page.dart';
import 'package:mobile_app_pilar/widgets/app_header.dart';
import 'content/component/footer.dart';
import 'content/page/kegiatan.dart';
import 'content/page/profile.dart';
import 'content/page/ubah_password.dart';
import 'screen/home_page.dart';
import 'screen/kegiatan/jadwal_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/Kegiatan': (context) => KegiatanScreen(),
        '/Profile': (context) => ProfileScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // MyContent(),
          Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => HomePage(),
              );
            },                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
          ),
          Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => KegiatanScreen(),
              );
            },
          ),
          Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: MyFooter(onTabTapped: _onTabTapped),
    );
  }
}

// class MyContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Dashboard',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }
