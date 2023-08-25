import 'package:flutter/material.dart';
import 'content/component/footer.dart';
import 'content/page/kegiatan.dart';
import 'content/page/profile.dart';
import 'content/page/ubah_password.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/search': (context) => KegiatanScreen(),
        '/favorites': (context) => ProfileScreen(),
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
      appBar: AppBar(
        title: Text('Flutter Footer Example'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          MyContent(),
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

class MyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Dashboard',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
