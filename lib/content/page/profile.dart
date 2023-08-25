import 'package:flutter/material.dart';
import './kegiatan.dart';
import './ubah_password.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget( content: "Nama", text: "Mohammad Faizal Agathon Rendi Ramadhan yahahaha h"),
                      SizedBox(height: 15),
                      TextWidget(content: "Username", text: "R2D2A2"),
                      SizedBox(height: 15),
                      TextWidget(content: "Level", text: "Admin"),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(), // Tambahkan garis pemisah
            CustomListTile(
              icon: Icons.lock,
              title: 'Ubah Password',
              iconColor: Colors.blueAccent,
              backgroundColor: Colors.greenAccent,
            ),
            SizedBox(height: 13),
            CustomListTile(
              icon: Icons.logout,
              title: 'Logout',
              iconColor: Colors.redAccent,
              backgroundColor: Colors.greenAccent,
            ),
          ],
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final String content;
  final String text;

  TextWidget({required this.content, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("$content : ",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
        Row(
          children: [
            Flexible( // Wrap the Text widget with Flexible
              child: Text(
                "$text",
                overflow: TextOverflow.fade, // Handle overflow with ellipsis
              ),
            )
          ],
        )
      ],
    ); 
  }
}

class CustomListTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Color backgroundColor;

  CustomListTile({
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.97;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
    _navigateToScreen();
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  void _navigateToScreen() {
    if (widget.title == 'Ubah Password') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UbahPasswordScreen()),
      );
    } else if (widget.title == 'Logout') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => KegiatanScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      transform: Matrix4.identity()..scale(_scale),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius:
            BorderRadius.circular(10), // Sesuaikan radius yang Anda inginkan
      ),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: ListTile(
          leading: Icon(widget.icon, color: widget.iconColor),
          title: Text(widget.title),
        ),
      ),
    );
  }
}
