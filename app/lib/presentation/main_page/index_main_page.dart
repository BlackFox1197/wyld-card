import 'package:flutter/material.dart';
import 'package:wyld_card/presentation/main_page/main_page_screens/own_card_overview/own_card_overview.dart';
import 'package:wyld_card/presentation/main_page/main_page_screens/settings/settings_index.dart';

class IndexMainPage extends StatefulWidget {
  const IndexMainPage({Key? key}) : super(key: key);

  @override
  State<IndexMainPage> createState() => _IndexMainPageState();
}

class _IndexMainPageState extends State<IndexMainPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    OwnCardOverview(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    SettingsIndex()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'My Cards',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card_outlined),
            label: 'Business',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.cyanAccent,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

