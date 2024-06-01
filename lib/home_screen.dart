import 'package:flutter/material.dart';
import 'bottom_navigation_bar.dart';
import 'product_screen.dart';
import 'ticket_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return ProductScreen();
      case 1:
        return TicketScreen();
      case 2:
        return ProfileScreen();
      default:
        return Container(); // Puedes devolver una pantalla vacía o manejar un caso predeterminado
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _getPage(_currentIndex),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
