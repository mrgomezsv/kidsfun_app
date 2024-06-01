import 'package:flutter/material.dart';
import 'my_app_bar.dart';
import 'bottom_navigation_bar.dart';
import 'product_screen.dart';
import 'ticket_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Main'),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(), // Evita el desplazamiento horizontal
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: <Widget>[
          ProductScreen(),
          TicketScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.jumpToPage(index); // Cambia de página sin animación
        },
      ),
    );
  }
}
