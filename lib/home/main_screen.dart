import 'package:flutter/material.dart';
import '../navigation/my_app_bar.dart';
import '../navigation/bottom_navigation_bar.dart';
import '../screen_principal/product_screen.dart';
import '../screen_principal/ticket_screen.dart';
import '../screen_principal/profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  // Lista de nombres de pantalla correspondientes a cada índice
  final List<String> _screenNames = ['Productos', 'Tickets', 'Perfil'];

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
      appBar: MyAppBar(title: _screenNames[_currentIndex]), // Usar el nombre de la pantalla actual
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
