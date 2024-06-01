import 'package:flutter/material.dart';
import 'my_app_bar.dart';
import 'bottom_navigation_bar.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Perfil'),
      body: Center(
        child: Text('Pantalla de perfil'),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 2, // Asegúrate de establecer el índice actual correctamente
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/product');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/ticket');
          } else if (index == 2) {
            // No necesitas hacer nada aquí ya que ya estás en la pantalla de Perfil
          }
        },
      ),
    );
  }
}
