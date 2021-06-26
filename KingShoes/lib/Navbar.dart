import 'package:flutter/material.dart';
import 'Dashboard.dart';
import 'Promo.dart';

class NavBot extends StatefulWidget {
  @override
  _NavBotState createState() => _NavBotState();
}

class _NavBotState extends State<NavBot> {
  int _selectedIndex = 0;
  List<Widget> _widgetOption = <Widget>[
    Dashboard(),
    Promo(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOption.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.black),
              )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
              color: Colors.red,
            ),
            title: Text(
              "List Produk",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
