import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(5.0), // Margen para separar la barra de los bordes de la pantalla
        height: 60, // Altura ajustada para evitar el desbordamiento
        decoration: BoxDecoration(
          color: Colors.blue, // Color de fondo azul
          borderRadius: BorderRadius.all(
            Radius.circular(30.0), // Bordes redondeados para la forma de cápsula
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0), // Asegura que los bordes redondeados se apliquen al contenido
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent, // Fondo transparente para ver el fondo azul del contenedor
            currentIndex: currentIndex,
            onTap: onTap,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart, size: 26, color: Colors.white),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_offer, size: 26, color: Colors.white),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 26, color: Colors.white),
                label: '',
              ),
            ],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed, // Esto asegura que los iconos estén centrados
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bottom Navigation Bar'),
        ),
        body: Center(
          child: Text('Content goes here'),
        ),
        bottomNavigationBar: MyBottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            // Handle tab change
          },
        ),
      ),
    );
  }
}
