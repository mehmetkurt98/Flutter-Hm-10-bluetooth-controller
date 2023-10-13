import 'package:flutter/material.dart';
import 'package:fluttet_hm10/view/amperview.dart';
import 'package:fluttet_hm10/view/home.dart';

class CustomStatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Home(),
    );
  }
}

class CustomAmperePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: AmperPage(),
    );
  }
}

class MyTabs extends StatefulWidget {
  @override
  _MyTabsState createState() => _MyTabsState();
}

class _MyTabsState extends State<MyTabs> {
  int _currentIndex = 0;
  final List<Widget> _pages = [CustomStatusPage(), CustomAmperePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Status",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: "Akım",
          ),
        ],
      ),
    );
  }
}
