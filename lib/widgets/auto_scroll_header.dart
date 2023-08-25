import 'package:flutter/material.dart';

class AutoScrollHeader extends StatefulWidget {
  @override
  _AutoScrollHeaderState createState() => _AutoScrollHeaderState();
}

class _AutoScrollHeaderState extends State<AutoScrollHeader> {
  final PageController _pageController =
      PageController(viewportFraction: 0.8);
  final List<String> imagePaths = [
    'assets/images/yor.gif',
    'assets/images/closure.gif',
    'assets/images/ame-amelia.gif',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(Duration(seconds: 3), () {
      int nextPage = (_pageController.page?.toInt() ?? 0) + 1;
      if (nextPage >= imagePaths.length) {
        nextPage = 0;
      }
      _pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 5000),
        curve: Curves.easeInOut,
      );
      _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
      child: PageView.builder(
        controller: _pageController,
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Image.asset(imagePaths[index]);
        },
      ),
    );
  }
}
