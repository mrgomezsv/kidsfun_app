import 'package:flutter/material.dart';
import 'my_app_bar.dart';
import 'bottom_navigation_bar.dart';

class TicketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Ticket'),
      body: Center(
        child: Text('Pantalla de ticket'),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 1, // Asegúrate de establecer el índice actual correctamente
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/product');
          } else if (index == 1) {
            // No necesitas hacer nada aquí ya que ya estás en la pantalla de Ticket
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),
    );
  }
}
