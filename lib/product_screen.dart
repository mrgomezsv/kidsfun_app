import 'package:flutter/material.dart';
import 'my_app_bar.dart';
import 'bottom_navigation_bar.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Producto'),
      body: Center(
        child: Text('Pantalla de producto'),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 0, // Asegúrate de establecer el índice actual correctamente
        onTap: (index) {
          if (index == 0) {
            // No necesitas hacer nada aquí ya que ya estás en la pantalla de Producto
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
