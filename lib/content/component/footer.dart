import 'package:flutter/material.dart';

class MyFooter extends StatefulWidget {
  final ValueChanged<int> onTabTapped;

  MyFooter({required this.onTabTapped});

  @override
  _MyFooterState createState() => _MyFooterState();
}

class _MyFooterState extends State<MyFooter> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          widget.onTabTapped(index);
        });
      },
      selectedItemColor: Color.fromARGB(255, 44, 75, 229),
      unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      backgroundColor: Color.fromARGB(255, 100, 255, 121),
      elevation: 10,
      items: [
        BottomNavigationBarItem(
          icon: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _currentIndex == 0 ? 36 : 26,
            child: Icon(
              Icons.speed,
              size: _currentIndex == 0 ? 36 : 26,
              ),
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _currentIndex == 1 ? 36 : 26,
            child: Icon(
              Icons.android,
              size: _currentIndex == 1 ? 36 : 26,
              ),
          ),
          label: 'Kegiatan',
        ),
        BottomNavigationBarItem(
          icon: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _currentIndex == 2 ? 36 : 26,
            child: Icon(
              Icons.person,
              size: _currentIndex == 2 ? 36 : 26,
              ),
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
