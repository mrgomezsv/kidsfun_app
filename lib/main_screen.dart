import 'package:flutter/material.dart';
import 'my_app_bar.dart';
import 'bottom_navigation_bar.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Main'),
      body: Center(
        child: Text('Pantalla principal con barra de navegación inferior'),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/product');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/ticket');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),
    );
  }
}
